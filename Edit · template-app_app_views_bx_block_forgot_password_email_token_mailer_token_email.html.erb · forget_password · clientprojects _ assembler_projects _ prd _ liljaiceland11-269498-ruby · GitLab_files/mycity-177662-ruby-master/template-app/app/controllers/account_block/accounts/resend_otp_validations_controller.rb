module AccountBlock
  module Accounts
    class ResendOtpValidationsController < ApplicationController
        include ActiveStorage::SetCurrent
      
      def create
        json_params = jsonapi_deserialize(params)
        if json_params['email'].present?
          # Get account by email
          @account = AccountBlock::EmailAccount
            .where(
              "LOWER(email) = ?",
              json_params['email'].downcase
            ).first

          return render json: {
            errors: [{
              msg: 'Account not found',
            }],
          }, status: :not_found if @account.nil?
          if @account.present?
            email_otp = AccountBlock::EmailOtp.new(email_otp_params)
            if email_otp.save
              send_email_for email_otp,@account
	            render json: {
	              message: "Verification OTP sent to your Email Successfully",
	              meta: {
	                      token: encoded_token
	                    }
	           		}
            else
              render json: {
                errors: [email_otp.errors],
              }, status: :unprocessable_entity
            end
          else
            render json: {message: "Account is not present please signup first"}
          end

        else
          return render json: {
            errors: [{
              msg: 'Email required',
            }],
          }, status: :unprocessable_entity
        end
      end

      private 

	    def email_otp_params
	      email = {:email => jsonapi_deserialize(params)["email"]}
	    end

	    def send_email_for(otp_record,account)
	      EmailOtpMailer
	        .with(account: account,otp: otp_record, host: request.base_url)
	        .email_otp.deliver_now
	    end

      def encoded_token
        BuilderJsonWebToken.encode @account.id, 10.minutes.from_now
      end
    end
  end
end

