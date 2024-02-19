module BxBlockNotifications
  class Notification < ApplicationRecord
    self.table_name = :notifications
    belongs_to :account , class_name: 'AccountBlock::Account', optional: true

    validates :headings, :contents, presence: true, allow_blank: false

    enum type: {push_notification: 0, email_notification: 1}

    scope :admin_notifications, -> {where(account_id: nil)}
  end
end
