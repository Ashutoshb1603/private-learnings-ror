module BxBlockNotifications
  class AbandonedCartNotificationWorker
    include Sidekiq::Worker
    FIREBASE_API_KEY = ENV["FIREBASE_SERVER_KEY"]
    def perform()
      start_time = 3.hours.ago.beginning_of_hour
      end_time = 3.hour.ago.end_of_hour
      accounts = AccountBlock::Account.joins(:cart_items).where('cart_items.updated_at >= ? and cart_items.updated_at <= ?', start_time, end_time).distinct
      data = Hash.new
      data[:title] =  "Items in Cart"
      data[:body] = "Hi, You have items in your cart"
      data[:tokens] = []
      # accounts = []
      # customer_accounts.each do |account|
      #   cart_item_updated_time = account&.cart_items&.last&.updated_at
      #   accounts << account if cart_item_updated_time.present? and ((Time.now - cart_item_updated_time)/3600).round == 3
      # end

      registration_ids = accounts.map(&:device_token)
      payload_data = {account_ids: accounts.map(&:id), notification_key: 'ShoppingCart', inapp: true, push_notification: true, all: true, type: 'admin', notification_for: 'order', key: 'order', redirect: 'cart'}
      BxBlockPushNotifications::FcmSendNotification.new(data[:body], data[:title], registration_ids, payload_data).call
      # Notification::NotificationService.new(data).send_notfification
      # notify data
    end

    private

    def notify(data)
      @fcm = FCM.new(FIREBASE_API_KEY)
      
      user_token = data[:tokens]
      payload_data = {
          "notification": {
              "title": data[:title],
              "body": data[:body]
          },
          "data": {
            "notification_type": "ShoppingCart"
          }
      }
      response = @fcm.send(user_token, payload_data)
    end
  end
end