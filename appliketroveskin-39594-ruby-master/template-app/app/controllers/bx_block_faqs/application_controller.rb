module BxBlockFaqs
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
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

  end
end
