module BxBlockNotifications
  class NotificationPeriod < ApplicationRecord
    self.table_name = :notification_periods

    ## Enumeration
    enum notification_type: {abandon_cart: "abandon_cart"}
    enum period_type: {minutes: 'minutes', hours: 'hours', days: 'days'}

    ## Validations
    validates :notification_type, :period_type, :period, presence: true
    validate  :validate_notification_period

    def validate_notification_period
      existing_record = NotificationPeriod.where(notification_type: notification_type)&.first
      if existing_record.present? && self.id != existing_record&.id
        errors.add(:notification_type, "You can only create one record for #{notification_type} category.")
      end
    end

    def get_cronjob_period
      if minutes?
        "*/#{period} * * * *"
      elsif hours?
        "0 */#{period} * * *"
      else
        "0 0 */#{period} * *"
      end
    end
  end
end