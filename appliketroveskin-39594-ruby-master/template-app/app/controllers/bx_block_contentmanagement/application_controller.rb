module BxBlockContentmanagement
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include Pagy::Backend
    
    before_action :validate_json_web_token
    before_action :is_freezed
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def shopify_products
      @@shopify_product = BxBlockShopifyintegration::ShopifyProductsController.new({country: @account.location})
    end

    def shopify_blogs
      @@shopify = BxBlockShopifyintegration::ShopifyBlogsController.new(params)
    end

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end
  end
end
