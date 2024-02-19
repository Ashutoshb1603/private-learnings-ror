module BxBlockAdmin
    class NotificationsController < ApplicationController
        include BuilderJsonWebToken::JsonWebTokenValidation
        before_action :current_user

        def create
            accounts = AccountBlock::Account.all
            if notification_paramas[:at].present?
                BxBlockNotifications::NotificationSchedule.create(notification_paramas)
                render json: {message: "Notification scheduled."}, status: :ok
            else
                payload_data = {account_ids: accounts.map(&:id), notification_key: 'customized_message', inapp: true, push_notification: true, all: true, type: 'broadcast', notification_for: 'broadcast', key: "broadcast"}
                BxBlockPushNotifications::FcmSendNotification.new(notification_paramas[:title], notification_paramas[:message], accounts.map(&:device_token), payload_data).call
                render json: {message: "Notification sent."}, status: :ok
            end
        end

        private
        def notification_paramas
            params["data"].require(:attributes).permit(:title, :message, :at)
        end
    end
end
