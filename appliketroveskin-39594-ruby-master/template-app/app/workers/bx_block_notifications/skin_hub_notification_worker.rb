module BxBlockNotifications
    class SkinHubNotificationWorker
      include Sidekiq::Worker
  
      def perform
        check_skin_hub
        favourite_products
      end

      def check_skin_hub
        accounts = AccountBlock::Account.joins(:membership_plans).where('end_date >= ? and membership_plans.created_at::date= ?', Time.now, 1.day.ago)
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'skin_hub', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'skin_hub', key: 'forum'}
        BxBlockPushNotifications::FcmSendNotification.new("Welcome to Skin Deep, we are here to educate and empower you. Check out our hubs and tutorials to learn more.", "Skin Hub", registration_ids, payload_data).call
      end

      def favourite_products
        accounts = AccountBlock::Account.joins(:customer_favourite_products).where('customer_favourite_products.created_at::date= ?', 30.day.ago).distinct
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'favourites', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'favourite_products', key: 'order'}
        BxBlockPushNotifications::FcmSendNotification.new("A product is in your favourites for 30 days now, view it here!", "Favourite Products", registration_ids, payload_data).call
      end

    end
end