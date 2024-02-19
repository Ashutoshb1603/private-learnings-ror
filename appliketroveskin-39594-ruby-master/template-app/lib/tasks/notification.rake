namespace :notification do
  desc "Abandoned Cart Notification"
  task abandoned_cart_notification: :environment do
    customer_accounts = AccountBlock::Account.joins(:cart_items)
    data = Hash.new
    data[:title] =  "Items in Cart"
    data[:body] = "Hi, You have items in your cart"
    data[:tokens] = []
    customer_accounts.each do |account|
      cart_item_updated_time = account.cart_items.last.updated_at
      data[:tokens] << account&.device_token if ((Time.now - cart_item_updated_time)/3600).round%10 == 0
    end
    Notification::NotificationService.new(data).send_notfification
  end

  desc "Scheduled Notification"
  task scheduled_notification: :environment do
    notification = BxBlockNotifications::NotificationSchedule.where('at >= ?', 1.minute.before).order(:at => :asc).first
    if notification.present? && notification.at.utc <= 15.minutes.after
      accounts = AccountBlock::Account.all
      payload_data = {account_ids: accounts.map(&:id), notification_key: 'customized_message', inapp: true, push_notification: true, all: true, type: 'broadcast', notification_for: 'broadcast', key: "broadcast"}
      BxBlockPushNotifications::FcmSendNotification.new(notification.title, notification.message, accounts.map(&:device_token), payload_data).call
    end
  end
end
