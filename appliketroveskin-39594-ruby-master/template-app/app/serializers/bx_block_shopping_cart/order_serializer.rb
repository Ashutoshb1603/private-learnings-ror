module BxBlockShoppingCart
  class OrderSerializer < BuilderBase::BaseSerializer

    attributes *[
        :id,
        :order_id,
        :status,
        :email,
        :phone,
        :financial_status,
        :line_items,
        :customer,
        :discount,
        :subtotal_price,
        :total_price,
        :shipping_charges,
        :shipping_title,
        :requires_shipping,
        :billing_address,
        :shipping_address,
        :created_at,
        :transaction_id,
        :way_of_payment,
        :currency
    ]

    attribute :shopify_attributes do |object, params|
      shopify_orders = params[:shopify_orders]
      shopify_order = params[:shopify_order]
      shopify_order = shopify_orders.select{|order| order if order["id"].to_s == object.order_id}.first if shopify_orders.present?
      shopify_order.present? ?
      {
        financial_status: shopify_order["financial_status"],
        fulfillment_status: shopify_order["fulfillment_status"],
        confirmed: shopify_order["confirmed"],
        closed_at: shopify_order["closed_at"],
        processed_at: shopify_order["processed_at"],
        processing_method: shopify_order["processing_method"],
        cancel_reason: shopify_order["cancel_reason"],
        cancelled_at: shopify_order["cancelled_at"]
      }
      :
      {}
    end

    attribute :customer do |object|
      AccountBlock::AccountSerializer.new(object.customer)
    end

    attribute :line_items do |object|
      LineItemsSerializer.new(object.line_items)
    end

    attribute :billing_address do |object|
      object.address.attributes.slice('country', 'latitude', 'longitude', 'street', 'county', 'postcode', 'address', 'city', 'province') if object.address.present?
    end

    attribute :shipping_address do |object|
      BxBlockAddress::Address.select(:country, :latitude, :longitude, :street, :county, :postcode, :address, :city, :province).find_by(id: object.shipping_id) if object.shipping_id.present?
    end

    attribute :way_of_payment do |object|
      payment = BxBlockPayments::Payment.find_by(charge_id: object.transaction_id) if object.transaction_id.present?
      obj = {}
      obj['payment_using'] = "Wallet"
      obj['last4'] = ""
      obj['brand'] = ""
      if payment.present?
        if payment['payment_gateway'] == 'stripe'
          Stripe.api_key = ENV['STRIPE_SECRET_KEY']
          # binding.pry
          begin
            charge = Stripe::Charge.retrieve(
              object.transaction_id,
            )
            obj = {}
            obj['payment_using'] = 'stripe'
            obj['last4'] = charge['payment_method_details']['card']['last4']
            obj['brand'] = charge['payment_method_details']['card']['brand']
            obj
          rescue Stripe::StripeError => e
            obj = {}
            obj['payment_using'] = 'stripe'
            obj['last4'] = ""
            obj['brand'] = ""
            obj['message'] = e
            obj
          end
        elsif payment['payment_gateway'] == 'paypal'
          obj['payment_using'] = 'paypal'
          obj['last4'] = ""
          obj['brand'] = ""
        else
          obj
        end
      end
      obj
    end
  end
end
