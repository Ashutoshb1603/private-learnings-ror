module BxBlockLogin
  class LoginsController < ApplicationController
    def create
      if params[:data][:attributes][:password].present? && params[:data][:attributes][:email].present?
        account = OpenStruct.new(jsonapi_deserialize(params))
        output = AccountAdapter.new
        
        output.on(:account_not_found) do |account|
          render json: {
            errors: [{
              failed_login: 'Account Not Found or Not Activated Please Check Your Email',
            }],
          }, status: :unprocessable_entity
        end

        output.on(:failed_login) do |account|
          render json: {
            errors: [{
              failed_login: 'Your password is incorrect',
            }],
          }, status: :unauthorized
        end

        output.on(:successful_login) do |account, token, refresh_token|
          render json: {meta: {
            message: "Login Successfully..!",
            token: token,
            refresh_token: refresh_token,
            account: account
          }}
        end

        output.login_account(account)
      
      else
        render json: {error: "Please Enter Email/Password"}, status: :unprocessable_entity
      end
    end
  end
end
