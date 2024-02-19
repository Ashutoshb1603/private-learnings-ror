module BxBlockNotifications
    class SkinGoalWorker
      include Sidekiq::Worker
  
      def perform(account_id)
        account = AccountBlock::Account.find(account_id)
        payload_data = {account: account, notification_key: 'skin_goal', inapp: true, push_notification: true, all: false, type: 'skin_goal', notification_for: 'skin_goal', key: 'skin_journey'}
        BxBlockPushNotifications::FcmSendNotification.new("You've successfully changed your skin goal! ", "Skin Goal", account&.device_token, payload_data).call
      end
    
  end
end