module BxBlockPushNotifications
  class PushNotificationsController < BxBlockPushNotifications::ApplicationController
    before_action :get_all_notification, only: [:index, :mark_read, :mark_unread, :destroy, :selected_notifications, :any_unread_msg]
    before_action :selected_notifications, only: [:mark_read, :mark_unread, :destroy]

    def index
      push_notifications = @push_notifications.order(created_at: :desc)
      if push_notifications.present?
        serializer = BxBlockPushNotifications::PushNotificationSerializer.new(
          push_notifications
        )
        render json: serializer.serializable_hash, status: :ok
      else
        render json: {
          errors: 'There is no push notification.'
        }, status: :not_found
      end
    end

    def mark_unread
      if params[:all] == "true"
        @push_notifications.update_all(is_read: false)
      else
        @selected_notifications.update_all(is_read: false)
      end
      render json: {message: "Updated successfully"}, status: :ok
    end

    def mark_read
      if params[:all] == "true"
        @push_notifications.update_all(is_read: true)
      else
        @selected_notifications.update_all(is_read: true)
      end
      render json: {message: "Updated successfully"}, status: :ok
    end

    def destroy
      if params[:all] == "true"
        @push_notifications.destroy_all
      else
        @selected_notifications.destroy_all
      end
      render json: {message: "Deleted successfully"}, status: :ok
    end

    def any_unread_msg
      @any_unread_msg = @push_notifications.where(is_read: false)
      if @any_unread_msg.present?
        render json: {unread_notification_present: true}, status: :ok
      else
        render json: {unread_notification_present: false}
      end
    end

    private

    def push_notifications_params
      params.require(:data)[:attributes].permit(
        :push_notificable_id,
        :push_notificable_type,
        :remarks, :is_read
      )
    end

    def get_all_notification
      @push_notifications = @current_user.push_notifications.where(push_notificable_type: "AccountBlock::Account")
    end

    def selected_notifications
      @selected_notifications = @push_notifications.where(id: params[:ids])
    end
  end
end
