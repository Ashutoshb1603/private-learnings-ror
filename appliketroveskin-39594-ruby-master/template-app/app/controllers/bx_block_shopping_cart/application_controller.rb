module BxBlockShoppingCart
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include Pagy::Backend
    
    before_action :validate_json_web_token
    before_action :is_freezed
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def shopify_products
      @@shopify_products = BxBlockShopifyintegration::ShopifyProductsController.new({country: current_user.location})
    end

    def shopify_orders
      @@shopify = BxBlockShopifyintegration::ShopifyOrdersController.new({country: current_user.location})
    end

    def shopify_taxes_and_shipping
      @@shopify_charges = BxBlockShopifyintegration::ShopifyTaxAndShippingController.new({country: current_user.location})
    end

    def shopify_discounts
      @@shopify_discounts = BxBlockShopifyintegration::ShopifyDiscountsController.new({country: current_user.location})
    end

    def location
      @location = "Ireland"
      @location = Geocoder.search([@params['latitude'], @params['longitude']]).first.country if @params.present?
      @location
    end

    def current_user
      begin
        raise "AdminAccountError" if @token.account_type == "AdminAccount"
        @current_user = AccountBlock::Account.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors:
            {message: 'Please login again.'}
        }, status: :unprocessable_entity
      rescue Exception => e
          return render json: {errors: 
            {message: "Please login with a customer account!"}
        }, status: :unprocessable_entity
      end
    end

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end
  end
end
