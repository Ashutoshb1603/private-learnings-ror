module BxBlockLogin
  class LoginsController < ApplicationController

    def create
      case params[:data][:user_type] #### rescue invalid API format

      when 'operator'

        if params[:data][:type]=='email_account'

          account=AccountBlock::Account.find_by(email: params[:data][:attributes][:email])
          if account.present? && account.activated?
            @email_otp = AccountBlock::EmailOtp.new(email: params[:data][:attributes][:email])
            @email_otp.user_type=account.user_type
            @email_otp.save

            AccountBlock::EmailOtpMailer.with(account: account, otp: @email_otp.pin, host: request.base_url).email_otp.deliver_now
            render json: AccountBlock::EmailOtpSerializer.new(@email_otp, meta: {
              token: BuilderJsonWebToken.encode(@email_otp.id),
            }).serializable_hash, status: :created
          else
              render json: {
              errors: [{
                failed_login: 'Account not found, or not activated',
              }],
            }, status: :unprocessable_entity
          end
          # output = AccountAdapter.new
          # output.on(:successful_login) do |account, token, refresh_token|
          #   render json: {meta: {
          #     token: token,
          #     refresh_token: refresh_token,
          #     id: account.id,
          #     message: "successfully login"
          #   }},status: :created
          # end
        else 
          render json: {
              errors: [{
                failed_login: 'Invalid Account Type',
              }],
            }, status: :unprocessable_entity
        end


      when 'charterer'

        case params[:data][:type]

        when 'email_account'
          account=AccountBlock::Account.find_by(email: params[:data][:attributes][:email])
          if account.present? && account.activated?
            @email_otp = AccountBlock::EmailOtp.new(email: params[:data][:attributes][:email])
            @email_otp.user_type=account.user_type
            @email_otp.save
            
            AccountBlock::EmailOtpMailer.with(account: account, otp: @email_otp.pin, host: request.base_url).email_otp.deliver_now
            render json: AccountBlock::EmailOtpSerializer.new(@email_otp, meta: {
              token: BuilderJsonWebToken.encode(@email_otp.id),
            }).serializable_hash, status: :created
          else
              render json: {
              errors: [{
                failed_login: 'Account not found, or not activated',
              }],
            }, status: :unprocessable_entity
          end
          # output = AccountAdapter.new

          # output.on(:successful_login) do |account, token, refresh_token|
          #   render json: {meta: {
          #     token: token,
          #     refresh_token: refresh_token,
          #     id: account.id,
          #     message: "successfully login"
          #   }},status: :created
          # end

        when 'sms_account'

          account=AccountBlock::Account.find_by(full_phone_number: params[:data][:attributes][:full_phone_number])
          if account.present? && account.activated?

            @sms_otp = AccountBlock::SmsOtp.new(full_phone_number: params[:data][:attributes][:full_phone_number])
            @sms_otp.user_type=account.user_type
            @sms_otp.save
            render json: AccountBlock::SmsOtpSerializer.new(@sms_otp, meta: {
              token: BuilderJsonWebToken.encode(@sms_otp.id)
            }).serializable_hash, status: :created
          else
            render json: {
            errors: [{
              failed_login: 'Account not found, or not activated',
            }],
          }, status: :unprocessable_entity
          end

          # output = AccountAdapter.new
          # output.on(:successful_login) do |account, token, refresh_token|
          #   render json: {meta: {
          #     token: token,
          #     refresh_token: refresh_token,
          #     id: account.id,
          #     message: "successfully login"
          #   }},status: :created
          # end
  
          else
            render json: {
              errors: [{
                account: 'Invalid Account Type',
              }],
            }, status: :unprocessable_entity
          end
        else
          render json: {
            errors: [{
              account: 'Invalid User Type',
            }],
          }, status: :unprocessable_entity
        end
    end
  end
end
        