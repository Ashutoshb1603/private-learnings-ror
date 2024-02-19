module BxBlockFeatureSettings
	class LogoutsController < ApplicationController
		include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token

    def destroy
    	header_token = request.headers[:token]
	      if header_token.present?
	        begin
	          @token = BuilderJsonWebToken.decode(header_token)
	          # expiring token here
	          token = encoded_token
      			render json: {
      				message: "Logout Successfully..",
      				meta: {
		            token: token,
		          }},status: 200

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

    private

  	def encoded_token
  		BuilderJsonWebToken.encode @token.id, Time.now
		end
	end
end
