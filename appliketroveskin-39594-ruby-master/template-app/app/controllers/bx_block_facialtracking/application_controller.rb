module BxBlockFacialtracking
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include Pagy::Backend
    
    before_action :validate_json_web_token
    before_action :is_freezed
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end

    def current_user
      begin
        @current_user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
        @current_user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors:
            {message: 'Please login again.'}
        }, status: :unprocessable_entity
      end
    end
  end
end
