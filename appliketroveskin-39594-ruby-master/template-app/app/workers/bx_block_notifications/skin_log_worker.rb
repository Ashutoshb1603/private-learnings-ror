module BxBlockNotifications
    class SkinLogWorker
      include Sidekiq::Worker
  
      def perform
        missed_skin_log
        n_days_in_a_row
      end

      def missed_skin_log
        # date = 7.days.ago.beginning_of_day
        # accounts = AccountBlock::Account.joins(:user_images).where.not('user_images.created_at >= ?', date).distinct
        # registration_ids = accounts.map(&:device_token)
        # payload_data = {account_ids: accounts.map(&:id), notification_key: 'skin_log_missed', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'skin_log_missed', key: 'skin_journey'}
        # BxBlockPushNotifications::FcmSendNotification.new("What gets measured, gets managed. Update your skin log today!", "Update your skin log today!", registration_ids, payload_data).call
        today = Date.today
        accounts = []
        AccountBlock::Account.all.each do |account|
          if account.last_update_log.present? && ((today - account.last_update_log).to_i <= 7)
            case (today - account.last_update_log).to_i
            when 1
              accounts << account
            when 3
              accounts << account
            when 7
              accounts << account
            end
          else
            case (today - account.last_notification).to_i
            when 1
              accounts << account
            when 3
              accounts << account
            when 7
              accounts << account
            end
          end
        end
        accounts = AccountBlock::Account.where(id: accounts.map(&:id))
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'skin_log_missed', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'skin_log_missed', key: 'skin_journey'}
        BxBlockPushNotifications::FcmSendNotification.new("What gets measured, gets managed. Update your skin log today!", "Update your skin log today!", registration_ids, payload_data).call
        accounts.update_all(last_notification: Date.today)
      end

      def n_days_in_a_row
        date_31_days_ago = 31.days.ago.beginning_of_day
        date_30_days_ago = 30.days.ago.beginning_of_day
        date_8_days_ago = 8.days.ago.beginning_of_day
        date_7_days_ago = 7.days.ago.beginning_of_day

        accounts_logged_for_31_days = AccountBlock::Account.joins(:user_images).where('user_images.created_at >= ?', date_31_days_ago).group(:id).having("count(user_images.id) >= #{31}").distinct
        accounts_logged_for_30_days = AccountBlock::Account.joins(:user_images).where('user_images.created_at >= ?', date_30_days_ago).group(:id).having("count(user_images.id) >= #{30}").distinct
        accounts_logged_for_8_days = AccountBlock::Account.joins(:user_images).where('user_images.created_at >= ?', date_8_days_ago).group(:id).having("count(user_images.id) >= #{8}").distinct
        accounts_logged_for_7_days = AccountBlock::Account.joins(:user_images).where('user_images.created_at >= ?', date_7_days_ago).group(:id).having("count(user_images.id) >= #{7}").distinct
        accounts_logged_for_7_days = accounts_logged_for_7_days - accounts_logged_for_8_days
        accounts_logged_for_30_days = accounts_logged_for_30_days - accounts_logged_for_31_days

        accounts = accounts_logged_for_7_days
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'skin_log', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'skin_log_added', key: 'skin_journey'}
        BxBlockPushNotifications::FcmSendNotification.new("Well done - you’ve logged 7-days in a row!", "Skin Log Update", registration_ids, payload_data).call

        accounts = accounts_logged_for_30_days
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'skin_log', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'skin_log_added', key: 'skin_journey'}
        BxBlockPushNotifications::FcmSendNotification.new("Well done - you’ve logged 30-days in a row!", "Skin Log Update", registration_ids, payload_data).call
    end
    
  end
end