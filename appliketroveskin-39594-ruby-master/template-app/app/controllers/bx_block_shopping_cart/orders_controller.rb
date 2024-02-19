module BxBlockShoppingCart
  class OrdersController < ApplicationController
    before_action :get_user, only: [:create, :past_orders]
    # before_action :get_service_provider, only: %i(get_booked_time_slots)
    # before_action :current_user
    before_action :shopify_orders
    @@silent_job = BxBlockNotifications::SilentNotificationJob

    def create
      shopify_order = @@shopify.create_orders(@customer, order_params)
      if shopify_order["errors"].present?
        render json: shopify_order, status: 400
      else
        if shopify_order["order"]["id"].present?
          order = Order.create(order_params.merge(
            customer_id: @customer.id, 
            order_id: shopify_order["order"]["id"], 
            discount: shopify_order["order"]["total_discounts"], 
            subtotal_price: shopify_order["order"]["subtotal_price"], 
            total_price: shopify_order["order"]["total_price"],
            status: shopify_order["order"]["fulfillment_status"],
            total_tax: (shopify_order["order"]["tax_lines"]&.first["price"].to_d if shopify_order["order"]["tax_lines"]&.first.present?),
            tax_title: (shopify_order["order"]["tax_lines"]&.first["title"] if shopify_order["order"]["tax_lines"]&.first.present?),
            shipping_charges: shopify_order["order"]["shipping_lines"].first["price"],
            shipping_title: shopify_order["order"]["shipping_lines"].first["title"],
            financial_status: 'paid',
            currency: (@customer.location.downcase == "ireland" ? "eur" : "gbp"),
          ).except("cart_item_ids", "discount_codes"))
          line_items = []
          @titles = []
          i = 0
          shopify_order["order"]["line_items"].each do |line_item|
            line_items << (line_item.slice("variant_id", "product_id", "quantity", "price", "total_discount").merge(product_image_url: shopify_order[:images][i][1], name: line_item['title']))
          @titles << line_item['title']
            i+=1
          end
          order.line_items.create(line_items)
          @titles = @titles.uniq
          update_recommend_products(@titles, order)
          

          discount_code = @customer.discount_code_usages.create(discount_code: shopify_order["order"]["discount_codes"].first["code"], value_type: shopify_order["order"]["discount_codes"].first["type"], amount: shopify_order["order"]["discount_codes"].first["amount"], order_id: order.id) if shopify_order["order"]["discount_codes"].present?
        end
        @customer.notifications.where('created_at >= ? and headings = ?', 1.day.ago.beginning_of_day, "Items in Cart").update(purchased: true)
        @@silent_job.perform_later(@customer, false)
        render json: OrderSerializer.new(order, params: {shopify_order: shopify_order}).serializable_hash
      end
    end

    def update_recommend_products(titles, order)
      recommended_products = BxBlockCatalogue::RecommendedProduct.where(account_id: order.customer_id, title: titles)
      if recommended_products.present?
        order.line_items.each do |line|
          products = recommended_products.where(title: line.name)
          products.each do |product|
            product.purchased =  true
            product.purchases.create(quantity: line.quantity.to_i)
            product.save!
          end
        end
      end
    end

    def cancel
      shopify_order = @@shopify.cancel_order(@customer, params[:id], cancel_order_params)
      if shopify_order["errors"].present?
        render json: shopify_order, status: 400
      else
        order = BxBlockShoppingCart::Order.find_by_order_id(params[:id])
        order.update(cancel_reason: cancel_order_params[:reason], cancelled_at: Time.now)
        stripe, error = BxBlockPayments::StripePayment.stripe_refund(amount: order.total_price.to_i, charge_id: order.transaction_id)
        if stripe.present? && stripe.status == "succeeded"
          @refund = BxBlockPayments::Refund.new(charge_id: order.transaction_id, refund_id: stripe.id)
          @refund.save
          render json: {data: {message: "Order cancelled successfully, your refund is successful.", order: shopify_order, refund: @refund}}, status: 200
        else
          render json: {errors: {message: "Unsuccessful refund."}}, status: 500
        end
      end
    end

    def show
      order = BxBlockShoppingCart::Order.find_by_order_id(params[:id])
      render json: {errors: {message: 'Order does not exist'}} and return unless order.present?
      location = order.currency == "eur" ? ["Ireland", "United Kingdom"] : ["United Kingdom", "Ireland"]
      shopify_order = @@shopify.order_view(order.order_id, location[0])["order"]
      shopify_order = @@shopify.order_view(order.order_id, location[1])["order"] if shopify_order.blank?
      render json: BxBlockShoppingCart::OrderSerializer.new(order, params: {shopify_order: shopify_order})
    end

    def past_orders
      orders = @customer.orders.order('created_at DESC')
      begin
        paginated_orders = pagy(orders, page: params[:page], items: 10)
        rescue Pagy::OverflowError => error
            render json: {message: "Page doesn't exist", error: error}, status: 404
        else
            shopify_orders = @@shopify.order_list(paginated_orders.second.pluck(:order_id), "Ireland")["orders"]
            shopify_orders = shopify_orders + @@shopify.order_list(paginated_orders.second.pluck(:order_id), "United Kingdom")["orders"] 
            render json: BxBlockShoppingCart::OrderSerializer.new(paginated_orders.second, params: {shopify_orders: shopify_orders}, meta: {page_data: paginated_orders.first}).serializable_hash
        end
    end

    def locations
      locations = @@shopify.locations
      user = AdminUser.first
      shopify_addresses = BxBlockAddress::Address.where.not(shopify_address_id: nil)
      locations["locations"].each do |location|
        address = BxBlockAddress::Address.find_or_initialize_by(shopify_address_id: location["id"])
        address.update!(country: location["country_name"], street: location["address1"], city: location["city"], province: location["province"], postcode: location["zip"], addressable: user, address_type: 'Other', county: location["address1"], address: location["address1"])
      end
      render json: {pickup_locations: shopify_addresses}
    end



    private
    def order_params
      params.require(:order).permit(:email, :phone, :address_id, :shipping_id, :transaction_id, :requires_shipping, cart_item_ids: [], discount_codes: [:id, :code, :amount, :type])
    end

    def cancel_order_params
      params.require(:order).permit(:reason, :email, :amount)
    end

    def get_user
      @customer = AccountBlock::Account.find(@token.id)
      render json: {errors: {message: 'Customer is invalid'}} and return unless @customer.present? or @token.account_type != "AdminAccount"
    end
  end
end
