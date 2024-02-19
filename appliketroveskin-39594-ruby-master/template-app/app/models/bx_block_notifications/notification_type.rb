module BxBlockNotifications
    class NotificationType < ApplicationRecord
        self.table_name = :notification_types
        has_many :account_notification_statuses, class_name: 'BxBlockNotifications::AccountNotificationStatus', dependent: :destroy
        
    end
end
