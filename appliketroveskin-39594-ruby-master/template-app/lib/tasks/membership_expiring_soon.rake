namespace :membership_expiring_soon do
    desc "Membership Expiring soon"
    task notify: :environment do
        accounts = AccountBlock::Account.joins(:membership_plans).where('end_date < ? and end_date > ?', 5.days.after, Time.now)
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'membership_expiring', all: true, inapp: true, push_notification: true, type: 'admin', redirect: "home_page", key: "plan"}
        BxBlockPushNotifications::FcmSendNotification.new("Reminder that the subscription will be renewed automatically", "Your subscription plan will be renewed automatically", registration_ids, payload_data).call
    end
end