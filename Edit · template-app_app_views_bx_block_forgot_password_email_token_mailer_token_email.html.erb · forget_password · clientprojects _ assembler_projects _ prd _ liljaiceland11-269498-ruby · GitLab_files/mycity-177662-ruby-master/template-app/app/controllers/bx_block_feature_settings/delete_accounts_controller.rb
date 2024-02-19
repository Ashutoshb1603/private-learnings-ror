module BxBlockFeatureSettings
	class DeleteAccountsController < ApplicationController
		include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token
    def destroy
    	header_token = request.headers[:token]
      if header_token.present?
        begin
          @token = BuilderJsonWebToken.decode(header_token)
          account = AccountBlock::Account.find(@token.id)&.update(activated: false)
    			render json: {message: "Account Deleted Successfully..",
	          }

        rescue JWT::DecodeError => e
          return render json: {
            errors: [{
              token: 'Invalid token',
            }],
          }, status: :bad_request
        end
      else
   			render json: {message: "Token Required"}
      end
    end
	end
end
