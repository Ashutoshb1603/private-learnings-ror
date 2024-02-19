module BxBlockStripeIntegration
  class PaymentMethodsController < BxBlockStripeIntegration::ApplicationController
    def create_customer_card
      card_params = jsonapi_deserialize(params)
      card = PaymentMethod.create_card(current_user, card_params)
      create_source = PaymentMethod.create_customer_source(current_user.stripe_id, card.id)
      payment_method = PaymentMethod.create(account_id: current_user.id, card_token: create_source.id)
      if create_source && payment_method
        render json: PaymentMethodSerializer.new(payment_method, meta: {
          card: card,
        }).serializable_hash, status: :created
      else
        render json: {
          errors: [{
            account: 'Invalid data format',
          }],
        }, status: :unprocessable_entity
      end
    end

    def create_payments
      payment_params = jsonapi_deserialize(params)
      payment = Payment.new(payment_params)
      payment_charge = Payment.charge(current_user, payment_params )
      if payment.save && payment_charge
        render json: PaymentSerializer.new(payment).serializable_hash, status: :created
      else
        render json: {
          errors: [{
            account: 'Invalid data format',
          }],
        }, status: :unprocessable_entity
      end
    end

    def create_subscription
     subscription = Stripe::Subscription.create({customer: current_user.stripe_id, items: [{plan: 'monthly_plan_key'}]})
     update_user = current_user.update(stripe_subscription_id: subscription.id, stripe_subscription_date: Time.now())
      if update_user
          render json: AccountBlock::EmailAccountSerializer.new(current_user, meta: {
            token: encode(current_user.id),
          }).serializable_hash, status: :created
      else
        render json: {
          errors: [{
            account: 'Invalid data format',
          }],
        }, status: :unprocessable_entity
      end
    end

    def cancel_subscription
      cancel_subscription = Stripe::Subscription.delete(current_user.stripe_subscription_id)
      update_user = current_user.update(stripe_subscription_id: nil, stripe_subscription_date: nil)
      if update_user
          render json: AccountBlock::EmailAccountSerializer.new(current_user, meta: {
            token: encode(current_user.id),
          }).serializable_hash, status: :created
      else
        render json: {
          errors: [{
            account: 'Invalid data format',
          }],
        }, status: :unprocessable_entity
      end

    end

    private

    def encode(id)
      BuilderJsonWebToken.encode id
    end
  end
end
