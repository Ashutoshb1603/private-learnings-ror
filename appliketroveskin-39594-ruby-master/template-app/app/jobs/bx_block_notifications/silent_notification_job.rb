module BxBlockNotifications
    class SilentNotificationJob < ApplicationJob
        queue_as :bx_block_notifications

        def perform(account, all=false)
            fcm = FCM.new(ENV["FIREBASE_SERVER_KEY"])
            if all 
                accounts = AccountBlock::Account.where('device_token IS NOT NULL')
            else
                accounts = [account]
            end
            accounts.each do |account|
                if account.present?
                notification_count = account&.notifications&.unread&.count || 0
                product_cart_count = account&.cart_items&.count || 0
                message_count = account.therapist? ? account&.customer_chats&.last&.messages&.where(is_read: false)&.count : account&.chats&.last&.messages&.where(is_read: false)&.count
                message_count = message_count || 0
                options = {
                    "content_available": true,
                    "data": {
                        notification_count: notification_count,
                        product_cart_count: product_cart_count,
                        message_count: message_count
                    }
                }
                response = fcm.send(account.device_token, options)
                end
            end
        end
    end
end