module BxBlockNotifications 
  class ScheduledNotificationWorker
    include Sidekiq::Worker

    def perform()
      notification = BxBlockNotifications::NotificationSchedule.where('at >= ?', 1.minute.before).order(:at => :asc).first
      if notification.present? && notification.at.utc <= 15.minutes.after
        accounts = AccountBlock::Account.all
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'customized_message', inapp: true, push_notification: true, all: true, type: 'broadcast', notification_for: 'broadcast', key: "broadcast"}
        BxBlockPushNotifications::FcmSendNotification.new(notification.title, notification.message, accounts.map(&:device_token), payload_data).call
      end
    end
  end
end