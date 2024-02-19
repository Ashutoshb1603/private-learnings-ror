module BxBlockPushNotifications
    class FcmSendNotification
      attr_accessor :title, :registration_ids, :fcm_client, :data, :is_created
    
      def initialize(account_emails:, name:, type:, title:)
        @fcm_client = FCM.new(ENV['FCM_SERVER_KEY'])
        @account_emails = account_emails
        @name = name
        @type = type
        @title = title
      end
  
      def call
        device_ids = AccountBlock::Account.joins(:devices).where(email: @account_emails).pluck(:token).uniq
        options = { 
            "notification": {"title": @title, sound: 'default'},
            data: {name: @name, type: @type},
            apns: {
                    payload: {
                    aps: {
                        sound: 'default',
                    }
                    },
                },
            android: {
                notification: {
                    sound: 'default',
                },
            },
        }
        response = fcm_client.send(device_ids.compact.uniq, options) if device_ids
      end
    end
  end