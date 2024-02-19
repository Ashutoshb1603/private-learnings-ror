module BxBlockPayments
  class MonthlyPaymentWorker
    include Sidekiq::Worker

    def perform()
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      subscriptions = BxBlockPayments::Subscription.where(frequency: 'monthly', is_cancelled: false)
      # BxBlockPayments::Payment.add_money_in_wallet(subscriptions, 30)
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
            description: "Monthly payment for #{customer.email}"
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
          date = Date.today.at_beginning_of_month.next_month
          subscription.update(next_payment_date: date)
        end
      end
    end
  end
end