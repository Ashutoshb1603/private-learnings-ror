module BxBlockLogin
  class LoginsController < ApplicationController
    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account', 'email_account', 'social_account', 'admin_account'
        account = OpenStruct.new(jsonapi_deserialize(params))
        account.type = params[:data][:type]

        output = AccountAdapter.new
        output.on(:account_not_found) do |account|
          render json: {
            errors: {
              message: 'Account not found or activated'
            }
          }, status: :unprocessable_entity
        end

        output.on(:failed_login) do |account|
          render json: {
            errors: {
              message: 'Password is incorrect'
            }
          }, status: :unauthorized
        end

        output.on(:successful_login) do |account, token|
          type = account.type
          sign_in_count = account.type != "AdminAccount" ? account.sign_in_count.eql?(0) : 0
          render json: "AccountBlock::#{type}Serializer".constantize.new(account, meta: {
            token: token, skin_quiz: (account.try(:account_choice_skin_quizzes).nil? ? false : account.account_choice_skin_quizzes.empty?)
          }).serializable_hash
          account.update(sign_in_count: account.sign_in_count + 1, device_token: params[:data][:device_token], device: params[:data][:device])
        end

        output.login_account(account)
      else
        render json: {
          errors: {
            message: 'Invalid Account Type'
          }
        }, status: :unprocessable_entity
      end
    end
  end
end
