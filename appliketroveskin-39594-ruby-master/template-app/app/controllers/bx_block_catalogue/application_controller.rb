module BxBlockCatalogue
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, except: [:refresh_products, :get_products]
    before_action :is_freezed, except: [:refresh_products, :get_products]
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end

    def shopify_products
      @@shopify = BxBlockShopifyintegration::ShopifyProductsController.new({country: @account.location})
    end

    def current_user
      begin
      @current_user = AccountBlock::Account.find_by(id: @token.id) unless @token.account_type == "AdminAccount"
      @current_user = AdminUser.find_by(id: @token.id) if @token.account_type == "AdminAccount"
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors:
          {message: 'Please login again.'}
        }, status: :unprocessable_entity
      end
    end
  end
end
