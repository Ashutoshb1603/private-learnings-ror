module BxBlockPayments
  class DailyPaymentWorker
    include Sidekiq::Worker

    def perform()
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      subscriptions = BxBlockPayments::Subscription.where(frequency: 'daily', is_cancelled: false)
      @@wallet = BxBlockPayments::WalletsController.new
      subscriptions.each do |subscription|
        customer = AccountBlock::Account.find(subscription.account_id)
        
        stripe_customer = Stripe::Customer.retrieve({ id: customer.stripe_customer_id })
        @payment = BxBlockPayments::Payment.new
        @payment.account_id = subscription.account_id
        begin
          charge = Stripe::Charge.create({
            amount: ((subscription.amount).to_i * 100).to_s,
            currency: subscription.currency,
            customer: customer.stripe_customer_id,
            source: stripe_customer.default_source,
            description: "Daily payment for #{customer.email}"
          })
          unless charge&.id.blank?
            # If there is a charge with id, set payment paid.
            @payment.charge_id = charge.id
            @payment.set_paid
            wallet = @@wallet.credit(customer, (subscription.amount).to_d)
          end
        rescue Stripe::StripeError => e
          # If a Stripe error is raised from the API,
          # set status failed and an error message
          @payment.error_message = e.message
          @payment.set_failed
        end
        if @payment.save
          subscription.update(next_payment_date: 1.days.from_now)
        end
      end
    end
  end
end
