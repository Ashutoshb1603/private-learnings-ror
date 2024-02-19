module BxBlockPayments

  class StripePayment
    INVALID_STRIPE_OPERATION = 'Invalid Stripe Operation'

    # charge create

    def initialize(current_user)
      @current_user = current_user
    end

    def self.execute(payment:, account:, payment_for:)
      begin
        plan = payment.plan
        # Check if the payment is a plan
        customer =  self.find_or_create_customer(card_token: payment.token, customer: account)
        if customer
          account.update(stripe_customer_id: customer.id)
          payment.customer_id = customer.id
        end
        # if plan&.stripe_plan_name.blank?
        description = "Skin Deep - #{payment_for.humanize} - #{account.name}"
        charge = self.execute_charge(price_cents: payment.price_cents,
                                    description: description,
                                    card_token:  payment.token, customer: customer, currency: payment.currency)
        # else
        #     charge = self.execute_subscription(plan: plan.stripe_plan_name,
        #                                       customer: customer)
        # end

        unless charge&.id.blank?
          # If there is a charge with id, set payment paid.
          payment.charge_id = charge.id
          payment.set_paid
        end
      rescue Stripe::StripeError => e
        # If a Stripe error is raised from the API,
        # set status failed and an error message
        payment.error_message = e.message
        payment.set_failed
      end
    end

    def self.pay_with_card(customer:, params:, payment:)
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      begin
        customer_id = customer.stripe_customer_id
        begin
          stripe_customer = Stripe::Customer.retrieve({ id: customer_id }) if customer_id.present?
        rescue Stripe::StripeError => e
          stripe_customer = Stripe::Customer.create({
            email: customer.email
          })
          customer.update(stripe_customer_id: stripe_customer.id)
        end
        if stripe_customer.blank?
          stripe_customer = Stripe::Customer.create({
            email: customer.email
          })
          customer.update(stripe_customer_id: stripe_customer.id)
        end
        charge = Stripe::PaymentIntent.create({
          amount: (params[:amount].to_i * 100).to_s,
          currency: payment.currency,
          customer: stripe_customer.id,
          source: params[:card_id],
          description: params[:description],
        })
        unless charge&.id.blank?
          # If there is a charge with id, set payment paid.
          payment.charge_id = charge.id
          payment.set_paid
        end
        return charge, nil
      rescue Stripe::StripeError => e
        # If a Stripe error is raised from the API,
        # set status failed and an error message
        payment.error_message = e.message
        payment.set_failed
        return nil, e
      end
    end


    def list_all_cards
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      begin
        customer_id = @current_user.stripe_customer_id
        begin
          stripe_customer = Stripe::Customer.retrieve({ id: customer_id }) if customer_id.present?
        rescue
          stripe_customer = Stripe::Customer.create({
            email: @current_user.email
          })
          @current_user.update(stripe_customer_id: stripe_customer.id)
        end
        if stripe_customer.blank?
          stripe_customer = Stripe::Customer.create({
            email: @current_user.email
          })
          @current_user.update(stripe_customer_id: stripe_customer.id)
        end
        cards = Stripe::PaymentMethod.list({
          customer: @current_user.stripe_customer_id,
          type: 'card',
        })
        return cards.data
      rescue Stripe::StripeError => e
        return e
      rescue => e
        return e
      end
    end

    def self.stripe_refund(amount:, charge_id:)
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      begin
        stripe = Stripe::Refund.create({
          amount: amount,
          charge: charge_id,
        })
        return stripe, nil
      rescue Stripe::StripeError => e
        return nil, e
      end
    end

    # def self.execute_subscription(plan:, customer:)
    #   subscriptions = Stripe::Subscription.list(customer: customer.id)
    #   subscriptions.each do |subscription|
    #     subscription.delete
    #   end
    #   Stripe::Subscription.create({
    #     customer: customer.id,
    #     items: [
    #       {
    #         plan: plan,
    #         quantity: 1
    #       },
    #     ],
    #   })
    # end

    def self.find_or_create_customer(card_token:, customer:)
      customer_id = customer.stripe_customer_id
      begin
        stripe_customer = Stripe::Customer.retrieve({ id: customer_id }) if customer_id.present?
      rescue Stripe::StripeError => e
        stripe_customer = Stripe::Customer.create({
          email: customer.email
        })
        customer.update(stripe_customer_id: stripe_customer.id)
      end
      if stripe_customer.blank?
        stripe_customer = Stripe::Customer.create({
          email: customer.email
        })
        customer.update(stripe_customer_id: stripe_customer.id)
      end
      address = customer.addresses&.last
      address_params =    {
                            city: address&.city,
                            country: address&.country,
                            line1: address&.street,
                            line2: address&.county,
                            postal_code: address&.postcode,
                            state: address&.province
                          }
      stripe_customer = Stripe::Customer.update(
                          stripe_customer.id, {
                          source: card_token,
                          name: customer.name, 
                          address: address_params,
                          shipping: { address:  address_params , name: customer.name },
                          })
      stripe_customer
    end

    private
    def self.execute_charge(price_cents:,
       description:, card_token:, customer:, currency:)
      Stripe::PaymentIntent.create({
        amount: (price_cents * 100).to_s,
        currency: currency,
        description: description,
        customer: customer.id,
        shipping: {
          name: customer.name,
          address: {
            line1: customer.address&.line1,
            postal_code: customer.address&.postal_code,
            city: customer.address&.city,
            state: customer.address&.state,
            country: customer.address&.country
          }
        }
      })
    end
  end
end

