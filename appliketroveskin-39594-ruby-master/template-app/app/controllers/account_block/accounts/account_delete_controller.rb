module AccountBlock
    module Accounts
      class AccountDeleteController < ApplicationController
        include BuilderJsonWebToken::JsonWebTokenValidation
  
        def show
            begin
                user_token = params[:token]
                token = BuilderJsonWebToken.decode(user_token)
                account = AccountBlock::EmailAccount.find(token.id)
                payload_data = {account: account, notification_key: 'sign_up', inapp: true, push_notification: true, all: false, type: 'sign_up', notification_for: 'sign_up', key: 'sign_up'}
                BxBlockPushNotifications::FcmSendNotification.new("You have successfully deleted your account.", "Account Deleted!", account&.device_token, payload_data).call
                AccountMailer.with(account: account).delete_account.deliver
                account.destroy if token.destroy && account.id == params[:id].to_i
            rescue JWT::ExpiredSignature
                return render json: {
                    errors: [{
                    pin: 'Link expired. Please request a new one.',
                    }],
                }, status: :unauthorized
            rescue JWT::DecodeError => e
                return render json: {
                    errors: [{
                    token: 'Invalid link',
                    }],
                }, status: :bad_request
            end
          redirect_to "https://skindeepapp.page.link/join"
        end
      end
    end
end
  