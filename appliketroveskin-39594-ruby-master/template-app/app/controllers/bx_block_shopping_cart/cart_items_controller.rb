module BxBlockShoppingCart
	class CartItemsController < ApplicationController
	  include BuilderJsonWebToken::JsonWebTokenValidation 
	  @@silent_job = BxBlockNotifications::SilentNotificationJob

	  before_action :current_user
	  before_action :get_cart_item, except: [:index, :create, :apply_discount, :get_taxes_and_shipping_charges]
	  before_action :get_serializer
	  before_action :shopify_taxes_and_shipping, only: :get_taxes_and_shipping_charges
	  before_action :shopify_discounts, only: :apply_discount
	  before_action :shopify_products, only: :create

	  def create
	  	cart_params = jsonapi_deserialize(params)	
	  	if check_item_already_in_cart(cart_params)
		  	cart_item = @current_user.cart_items.find_by(name: cart_params['name']) 
			cart_item.quantity = cart_params['quantity'] + cart_item.quantity
		else 
			product = @@shopify_products.product_show(cart_params['product_id'])["product"]
			product = @@shopify_products.product_with_title(cart_params['name'])["products"][0] if product.nil?
			if product.present?
				if cart_params['variant_id'].nil? || product['variants'].map{|x| x['id']}.exclude?(cart_params['variant_id'])
					cart_params['product_id'] = product['id']
					cart_params['variant_id'] = product['variants'][0]['id']
					cart_params['price'] = product['variants'][0]['price']
				end
				cart_item = @current_user.cart_items.new(cart_params)
			# else
			# 	new_location = @current_user.location.downcase == "ireland" ?  "United Kingdom" : "Ireland"
			# 	# @current_user.update(location: new_location)
			# 	product = @@shopify_products.product_show(cart_params['product_id'], new_location)["product"]
			# 	# shopify = BxBlockShopifyintegration::ShopifyProductsController.new({country: new_location})
			# 	new_product = @@shopify_products.product_with_title(cart_params['title'])["products"][0]

			# 	if new_product.present?
			# 		cart_params['product_id'] = new_product['id']
			# 		cart_params['variant_id'] = new_product['variants'][0]['id']
			# 		cart_params['price'] = new_product['variants'][0]['price']
			# 		cart_item = @current_user.cart_items.new(cart_params)
			# 	end
			end
		end
		if cart_item.present?
			cart_item.total_price = cart_item.quantity * cart_item.price
			cart_item.save!
			@@silent_job.perform_now(@current_user, false)
	  		render json: @serializer.new(cart_item, params: {current_user: @current_user}).serializable_hash
		else
			render json: {errors: {message: "Item is not available in #{current_user.location} store"}}, status: :unprocessable_entity
		end
	  end

	  def get_taxes_and_shipping_charges
	  	location = @current_user&.addresses&.last&.country
	  	if params[:shipping_id].present? && params[:shipping_id].to_i != 0
	  		location = BxBlockAddress::Address.find(params[:shipping_id])&.country
	  	end
			cart_items = @current_user.cart_items
			cart_total = 0
			cart_items.each do |item|
				cart_total += item.total_price
			end
			shipping_and_tax_lines = @@shopify_charges.calculate_charges(cart_total, location, true)
			render json: {shipping_and_tax_lines: shipping_and_tax_lines}
	  end

	  def apply_discount
		cart_items = @current_user.cart_items
		discount = @@shopify_discounts.get_discount(@current_user, cart_items, params[:discount_code]) if params[:discount_code].present?
		message, code = "Discount applied!", 200
		message, code = "Discount code not found!", 404 if discount == 0
		message, code = "Already used! Applicable only one time per customer.", 404 if discount == -1
		message, code = "Offer expired!", 404 if discount == -2
		message, code = "Discount code not applicable!", 404 if discount == -3
		render json: {discount: discount, message: message}, :status => code
	  end

	  def index
	  	cart_items = @current_user.cart_items.order('created_at ASC')
	  	render json: @serializer.new(cart_items, params: {current_user: @current_user}).serializable_hash
	  end

	  def show
	  	render json: @serializer.new(@cart_item, params: {current_user: @current_user}).serializable_hash
	  end

	  def update_quantity
	  	update_params = jsonapi_deserialize(params)
		param_quantity = update_params['quantity']
		if update_params['action'] == 'add'
			quantity = update_params['quantity'] + @cart_item.quantity
		else update_params['action'] == 'subtract'
			quantity =  @cart_item.quantity - param_quantity
		end
		@cart_item.update(quantity: quantity)
		@cart_item.update(total_price: @cart_item.quantity*@cart_item.price)
		@@silent_job.perform_now(@current_user, false)
		render json: @serializer.new(@cart_item, params: {current_user: @current_user}).serializable_hash
	  end

	  def update
	  	update_params = jsonapi_deserialize(params)
	  	@cart_item.update!(update_params)
	  	@cart_item.update(total_price: @cart_item.quantity*@cart_item.price) if update_params['quantity'].present?
		@@silent_job.perform_now(@current_user, false)
	  	render json: @serializer.new(@cart_item, params: {current_user: @current_user}).serializable_hash
	  end

	  def destroy
	  	@cart_item.destroy!
		@@silent_job.perform_now(@current_user, false)
	  	render json: {message:'successfully deleted'}
	  end

	  private
	  def get_cart_item	
	  	@cart_item = BxBlockShoppingCart::CartItem.find(params[:id])
	  end

	  def check_item_already_in_cart(cart_params)
	  	@current_user.cart_items.pluck(:name).include? cart_params['name']
	  end

	  def get_serializer
	  	@serializer  = BxBlockShoppingCart::CartItemSerializer
	  end
	end
end
