module BxBlockPushNotifications
  class FcmSendNotification
    @@silent_job = BxBlockNotifications::SilentNotificationJob
    attr_accessor :message, :title, :registration_ids, :fcm_client, :data
  
    def initialize(message, title, registration_ids, data, optional_data={})
      @message = message
      @title = title
      @registration_ids = registration_ids
      @fcm_client = FCM.new(ENV['FIREBASE_SERVER_KEY'])
      @data = data
      @optional_data = optional_data
      @optional_data = {
        "notification_type": data[:notification_key],
        "id": data[:record_id],
      } if @optional_data.nil? || @optional_data.empty?
    end

    def call
      # if registration_ids.present?
      notification_type = BxBlockNotifications::NotificationType.find_or_create_by(key: data[:key])
      disabled_account_ids = notification_type&.account_notification_statuses&.where(enabled: false).pluck(:account_id)
      disabled_accounts = AccountBlock::Account.where(id: disabled_account_ids)
      device_tokens = disabled_accounts.map(&:device_token) || []
      @registration_ids = [@registration_ids].flatten
      @registration_ids = @registration_ids - device_tokens if @registration_ids.present?
      @registration_ids.compact!
      account_ids = disabled_accounts.map(&:id) || []
      @data[:account_ids] = @data[:account_ids] - account_ids if @data[:account_ids].present?
      if data[:push_notification] == true
        if title.present? && message.present?
          options = { "notification": {"title": title, "body": message},
                      "data":  @optional_data}
        else
          options = { data: message }
        end
      end
      if data[:inapp] == true
        if data[:all] == true
          data[:account_ids].each do |key, value|
            BxBlockNotifications::Notification.create(accountable_id: key, accountable_type: "AccountBlock::Account", headings: title, contents: message, type_by_user: data[:type], created_by: data[:created_by], user_type: data[:user_type], redirect: data[:redirect], record_id: data[:record_id], notification_for: data[:notification_for], parent_id: data[:parent_id])
          end
        else
          BxBlockNotifications::Notification.create(accountable: data[:account], headings: title, contents: message, type_by_user: data[:type], created_by: data[:created_by], user_type: data[:user_type], redirect: data[:redirect], record_id: data[:record_id], notification_for: data[:notification_for], parent_id: data[:parent_id]) if data[:account].present?
        end
      end
      response = options.nil? ? "" : fcm_client.send(@registration_ids, options) unless @registration_ids.blank?
      
      @@silent_job.perform_later(nil, true)
      # end 
    end

  end
end