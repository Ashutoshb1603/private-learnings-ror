module BxBlockFeatureSettings
	class ChangePasswordsController < ApplicationController
	  include ActiveStorage::SetCurrent
		include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token

    def update 
      @account = AccountBlock::EmailAccount.find(@token.id)
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
          if @account.present?
            if create_params[:new_password] == create_params[:confirm_password]
              @account.update(password: create_params[:new_password])
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
    end

    private

    def encoded_token
      BuilderJsonWebToken.encode @account.id, 1.months.from_now
    end

    def create_params
      params.require(:data)
        .permit(*[
          :new_password,
          :confirm_password
        ])
    end
	end
end
