module BxBlockPayments
  class Payment < ApplicationRecord
    self.table_name = :payments
    belongs_to :account , class_name: 'AccountBlock::Account'
    belongs_to :plan , class_name: 'BxBlockPlan::Plan', optional: true
    enum status: { pending: 0, failed: 1, paid: 2}
    enum currency: { 'eur' => 1, 'gbp' => 2 }
    enum payment_gateway: { stripe: 0, paypal: 1, wallet: 2, in_app: 3}
    scope :recently_created, ->  { where(created_at: 1.minutes.ago..DateTime.now) }

    after_create :create_charge_id

    def create_charge_id
      if self.payment_gateway == 'wallet'
        begin
          self.charge_id = "wl_#{SecureRandom.hex(10)}"
        end while self.class.exists?(charge_id: self.charge_id)
        self.save
      end
    end

    def set_paid
      self.status = Payment.statuses[:paid]
    end

    def set_failed
      self.status = Payment.statuses[:failed]
    end

    def set_pending
      self.status = Payment.statuses[:pending]
    end

    def set_paypal_executed
      self.status = Payment.statuses[:paypal_executed]
    end

    def self.add_money_in_wallet(subscriptions, frequecy_days)
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      @@wallet = BxBlockPayments::WalletsController.new
      subscriptions.each do |subscription|
        customer = AccountBlock::Account.find(subscription.account_id)

        stripe_customer = Stripe::Customer.retrieve({ id: customer.stripe_customer_id })
        @payment = BxBlockPayments::Payment.new
        @payment.account_id = subscription.account_id
        begin
          charge = Stripe::Charge.create({
            amount: ((subscription.amount).to_i * 100).to_s,
            currency: 'inr',
            customer: customer.stripe_customer_id,
            source: stripe_customer.default_source
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
          subscription.update(next_payment_date: frequecy_days.days.from_now)
        end
      end
    end
  end
end

