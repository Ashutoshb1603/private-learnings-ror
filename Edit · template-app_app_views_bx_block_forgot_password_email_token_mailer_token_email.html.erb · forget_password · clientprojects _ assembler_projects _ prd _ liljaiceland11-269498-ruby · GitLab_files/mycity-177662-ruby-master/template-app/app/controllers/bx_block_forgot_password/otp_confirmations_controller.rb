module BxBlockForgotPassword
  class OtpConfirmationsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ActiveStorage::SetCurrent

    def create
      header_token = request.headers[:token]
      if header_token.present? && params[:otp].present?
        # Try to decode token with OTP information
        begin
          token = BuilderJsonWebToken.decode(header_token)
        rescue JWT::ExpiredSignature
          return render json: {
            errors: [{
              pin: 'OTP has been expired, please request a new one.',
            }],
          }, status: :unauthorized
        rescue JWT::DecodeError => e
          return render json: {
            errors: [{
              token: 'Invalid token',
            }],
          }, status: :bad_request
        end

        # Try to get OTP object from token
        begin
          account = AccountBlock::Account.find(token.id)
         if account.present?
          otp = AccountBlock::EmailOtp.where(email: account.email).last
         else
          render json: {error: "Account not found"}
         end
        rescue ActiveRecord::RecordNotFound => e
          return render json: {
            errors: [{
              otp: 'Token invalid',
            }],
          }, status: :unprocessable_entity
        end

        # Check OTP code
        if otp.present?
          if otp.pin == params[:otp].to_i
            all_otp = AccountBlock::EmailOtp.where(email: account.email)
            all_otp.destroy_all
            render json: {
              messages: [{
                otp: 'OTP validation success',
                token: encode(token.id)
              }],
            }, status: :created
          else
            return render json: {
              errors: [{
                otp: 'Invalid OTP code',
              }],
            }, status: :unprocessable_entity
          end
        else
            return render json: {
              errors: [{
                otp: 'otp not matched please signup again or resend otp',
              }],
            }, status: :unprocessable_entity
        end
      else
        return render json: {
          errors: [{
            otp: 'Token and OTP code are required',
          }],
        }, status: :unprocessable_entity
      end
    end

    private

    def encode(id)
      BuilderJsonWebToken.encode(id, 10.minutes.from_now, token_type: 'forget')
    end


    # def create
    #   if create_params[:token].present? && create_params[:otp_code].present?
    #     # Try to decode token with OTP information
    #     begin
    #       token = BuilderJsonWebToken.decode(create_params[:token])
    #     rescue JWT::ExpiredSignature
    #       return render json: {
    #         errors: [{
    #           pin: 'OTP has expired, please request a new one.',
    #         }],
    #       }, status: :unauthorized
    #     rescue JWT::DecodeError => e
    #       return render json: {
    #         errors: [{
    #           token: 'Invalid token',
    #         }],
    #       }, status: :bad_request
    #     end

    #     # Try to get OTP object from token
    #     # begin
    #     #   otp = token.type.constantize.find(token.id)
    #     # rescue ActiveRecord::RecordNotFound => e
    #     #   return render json: {
    #     #     errors: [{
    #     #       otp: 'Token invalid',
    #     #     }],
    #     #   }, status: :unprocessable_entity
    #     # end

    #     # Check OTP code
    #     if otp.pin == create_params[:otp_code].to_i
    #       otp.activated = true
    #       otp.save
    #       render json: {
    #         messages: [{
    #           otp: 'OTP validation success',
    #         }],
    #       }, status: :created
    #     else
    #       return render json: {
    #         errors: [{
    #           otp: 'Invalid OTP code',
    #         }],
    #       }, status: :unprocessable_entity
    #     end
    #   else
    #     return render json: {
    #       errors: [{
    #         otp: 'Token and OTP code are required',
    #       }],
    #     }, status: :unprocessable_entity
    #   end
    # end

    # private

    # def create_params
    #   params.require(:data)
    #     .permit(*[
    #       :email,
    #       :full_phone_number,
    #       :token,
    #       :otp_code,
    #       :new_password,
    #     ])
    # end
  end
end
