module BxBlockAdmin
  class ApplicationController < BuilderBase::ApplicationController
    # protect_from_forgery with: :exception
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

    def current_user
      @current_user = AdminUser.find_by(id: @token.id) if @token.account_type == "AdminAccount"
      unless @current_user.present?
        render json: {errors:
          {message: 'You are not authorized to view this section.'}
        }, status: :unprocessable_entity
      end
    end

    def not_found
      render :json => {'errors' => {"message" => "#{controller_name.singularize.titleize} with id #{params[:id]} doesn't exists"}}, :status => :not_found
    end
  end
end
