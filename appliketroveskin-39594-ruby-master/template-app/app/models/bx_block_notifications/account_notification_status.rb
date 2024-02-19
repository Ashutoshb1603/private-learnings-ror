module BxBlockNotifications
  class AccountNotificationStatus < ApplicationRecord
    self.table_name = 'account_notification_statuses'

    belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: 'account_id'
    belongs_to :notification_type, class_name: 'BxBlockNotifications::NotificationType'
  end
end
