module BxBlockStripeIntegration
  class Payment < BxBlockStripeIntegration::ApplicationRecord
    self.table_name = :payments
    belongs_to :account, class_name: "AccountBlock::Account"

    def self.charge(user, params)
      stripe_charge = stripe_charge(user.stripe_id, params["ammount"])
    end

    private

    def self.stripe_charge(stripe_id, amount)
      begin
        return Stripe::Charge.create({
          amount: amount,
          currency: "inr",
          customer: stripe_id,
          description: "charge"
        })
      rescue Stripe::StripeError => e
        logger.debug e
        raise
      end
    end
  end
end
