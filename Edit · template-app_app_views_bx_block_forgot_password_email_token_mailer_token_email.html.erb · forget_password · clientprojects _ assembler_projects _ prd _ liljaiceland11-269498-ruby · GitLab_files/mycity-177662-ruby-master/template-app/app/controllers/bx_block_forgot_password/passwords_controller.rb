module BxBlockForgotPassword
  class PasswordsController < ApplicationController
    include ActiveStorage::SetCurrent

    def create 
      header_token = request.headers[:token]
      if header_token.present?
        begin
          token = BuilderJsonWebToken.decode(header_token)
        rescue JWT::ExpiredSignature => e
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

        @account = AccountBlock::Account.find(token.id.to_s)

        unless @account.activated?
          return render json: {
            errors: [{
              message: 'Account not Activated',
            }],
          }, status: :unprocessable_entity
        else       
        # Check new password requirements
          password_validation = AccountBlock::PasswordValidation.new(create_params[:new_password])
          is_valid = password_validation.valid?
          # error_message = password_validation.errors.full_messages.first
          error_message = "Password should be a minimum of 8 characters long,one uppercase,lowercase characters,one digit & one special character"
          unless is_valid
            return render json: {
                errors: [{
                  password: error_message,
                }],
              }, status: :unprocessable_entity
          else
            # @account = AccountBlock::Account.find(token.id)
              if @account.present?
                if create_params[:new_password] == create_params[:confirm_password]
                  @account.update(password: create_params[:new_password],activated: true)
                  serializer = AccountBlock::AccountSerializer.new(@account)
                    serialized_account = serializer.serializable_hash
                    render json: {
                            Account: serialized_account, 
                            message: 'Password Reset Successfully', 
                                  meta: {
                                    token: encoded_token
                              },
                              status: :created 
                            }
                else
                  return render json: { errors: [{ message: 'Password not matched'}]}, status: :unprocessable_entity
                end
            else
                return render json: {
                  errors: [{
                    error: 'Account not found',
                  }],
                }, status: :unprocessable_entity
            end
          end
        end
      else
          return render json: {  errors: 'Token is required', status: :unprocessable_entity}
      end
    end

    private

    def encoded_token
      BuilderJsonWebToken.encode(@account.id, 1.months.from_now, token_type: 'login')
    end

    def create_params
      params.require(:data)
        .permit(*[
          # :email,
          # :full_phone_number,
          # :token,
          # :otp_code,
          :new_password,
          :confirm_password
        ])
    end
    # def create
    #   if create_params[:token].present? && create_params[:new_password].present?
    #     # Try to decode token with OTP information
    #     begin
    #       token = BuilderJsonWebToken.decode(create_params[:token])
    #     rescue JWT::DecodeError => e
    #       return render json: {
    #         errors: [{
    #           token: 'Invalid token',
    #         }],
    #       }, status: :bad_request
    #     end

    #     # Try to get OTP object from token
    #     begin
    #       otp = token.type.constantize.find(token.id)
    #     rescue ActiveRecord::RecordNotFound => e
    #       return render json: {
    #         errors: [{
    #           otp: 'Token invalid',
    #         }],
    #       }, status: :unprocessable_entity
    #     end

    #     # Check if OTP was validated
    #     unless otp.activated?
    #       return render json: {
    #         errors: [{
    #           otp: 'OTP code not validated',
    #         }],
    #       }, status: :unprocessable_entity
    #     else
    #       # Check new password requirements
    #       password_validation = AccountBlock::PasswordValidation
    #         .new(create_params[:new_password])

    #       is_valid = password_validation.valid?
    #       error_message = password_validation.errors.full_messages.first

    #       unless is_valid
    #         return render json: {
    #           errors: [{
    #             password: error_message,
    #           }],
    #         }, status: :unprocessable_entity
    #       else
    #         # Update account with new password
    #         account = AccountBlock::Account.find(token.account_id)

    #         if account.update(:password => create_params[:new_password])
    #           # Delete OTP object as it's not needed anymore
    #           otp.destroy

    #           serializer = AccountBlock::AccountSerializer.new(account)
    #           serialized_account = serializer.serializable_hash

    #           render json: serialized_account, status: :created
    #         else
    #           render json: {
    #             errors: [{
    #               profile: 'Password change failed',
    #             }],
    #           }, status: :unprocessable_entity
    #         end
    #       end
    #     end
    #   else
    #     return render json: {
    #       errors: [{
    #         otp: 'Token and new password are required',
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
