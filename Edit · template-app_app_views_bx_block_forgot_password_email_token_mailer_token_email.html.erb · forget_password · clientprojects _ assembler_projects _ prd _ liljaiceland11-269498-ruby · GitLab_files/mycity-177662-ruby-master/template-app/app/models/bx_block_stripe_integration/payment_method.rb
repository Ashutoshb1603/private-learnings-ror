module BxBlockStripeIntegration
  class PaymentMethod < BxBlockStripeIntegration::ApplicationRecord
    self.table_name = :payment_methods
    belongs_to :account, class_name: "AccountBlock::Account"

    def self.create_card(user, card_params)
      card = create_card_token(card_params)
    end

    private

    def self.create_card_token(card_params)
      begin
        return Stripe::Token.create(card: card_params)
      rescue Stripe::StripeError => e
        logger.debug e
        raise
      end
    end

    def self.create_customer_source(stripe_id, token)
      begin
        return Stripe::Customer.create_source(
        stripe_id,
          {source: token},
        )
      rescue Stripe::StripeError => e
        logger.debug e
        raise
      end
    end
  end
end