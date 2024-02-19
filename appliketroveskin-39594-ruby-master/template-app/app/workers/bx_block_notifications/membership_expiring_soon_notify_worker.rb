module BxBlockNotifications  
  class MembershipExpiringSoonNotifyWorker
    include Sidekiq::Worker

    def perform()
      date = DateTime.now.end_of_day
      accounts = AccountBlock::Account.joins(:membership_plans).where('end_date < ? and end_date > ?', date.next_day, date).distinct
      registration_ids = accounts.map(&:device_token)
      payload_data = {account_ids: accounts.map(&:id), notification_key: 'membership_expiring', all: true, inapp: true, push_notification: true, type: 'admin', redirect: "home_page", key: "plan"}
      BxBlockPushNotifications::FcmSendNotification.new("Reminder that the subscription will be renewed automatically tomorrow", "Your subscription plan will be renewed automatically tomorrow", registration_ids, payload_data).call
    end
  end
end