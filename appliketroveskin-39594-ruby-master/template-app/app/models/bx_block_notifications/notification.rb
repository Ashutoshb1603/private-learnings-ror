module BxBlockNotifications
  class Notification < ApplicationRecord
    self.table_name = :notifications
    belongs_to :accountable, polymorphic: true

    validates :headings, :contents, presence: true, allow_blank: false
    enum notification_type: {'admin': 1, 'abandoned_cart': 2, 'live_streaming': 3, 'consultation': 4}
    enum user_type: {'user': 1, 'guest': 2}
    
    scope :unread, -> {where(is_read: false)}
    scope :read, -> {where(is_read: true)}
  end
end
