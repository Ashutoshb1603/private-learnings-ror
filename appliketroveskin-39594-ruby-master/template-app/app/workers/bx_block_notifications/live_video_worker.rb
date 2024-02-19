module BxBlockNotifications
    class LiveVideoWorker
      include Sidekiq::Worker
  
      def perform(live_video)
        accounts = AccountBlock::Account.all
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'live_view', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'live_view', key: 'live', record_id: live_video, redirect: "live_view"}
        BxBlockPushNotifications::FcmSendNotification.new("Skin Deep was live - view here!", "Skin Deep was live", registration_ids, payload_data).call
      end
      
  end
end