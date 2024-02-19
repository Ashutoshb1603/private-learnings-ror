module BxBlockNotifications
    class NotificationTypesSerializer < BuilderBase::BaseSerializer
      attributes *[
          :id,
          :title,
          :description,
          :key
      ]
      
      attribute :enabled do |object, params|
        current_user = params[:current_user]
        status = current_user.account_notification_statuses.where(notification_type_id: object.id).first
        if status.present?
            status.enabled
        else
            true
        end
      end
    end
  end
  