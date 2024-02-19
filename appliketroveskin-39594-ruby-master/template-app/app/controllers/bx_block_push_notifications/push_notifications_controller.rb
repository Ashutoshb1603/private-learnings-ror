module BxBlockPushNotifications
  class PushNotificationsController < ApplicationController

    def create
      data = BxBlockPushNotifications::SendPushNotification.new(
        title: notification_params[:title],
        message: notification_params[:message],
        app_url: notification_params[:app_url],
        user_ids: notification_params[:user_ids]
      ).call
      render json: { data: data }
    end

    private

    def notification_params
      params.require(:notification).permit(
        :title, :message, :app_url, user_ids: []
      )
    end
  end
end
