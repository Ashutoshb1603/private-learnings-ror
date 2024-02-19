module BxBlockNotifications
    class NotificationTypesController < ApplicationController
        before_action :current_user

        def index
            @notification_types = NotificationType.where.not(title: nil).order(:title)
            render json: NotificationTypesSerializer.new(@notification_types, params: {current_user: current_user}).serializable_hash
        end

        def enable_or_disable
            @notification_types = NotificationType.where.not(title: nil).order(:title)
            @notification_type = @notification_types.find(params[:id])
            notification_status = current_user.account_notification_statuses.find_or_initialize_by(notification_type: @notification_type)
            notification_status.persisted? ? notification_status.toggle!(:enabled) : notification_status.save!
            
            render json: NotificationTypesSerializer.new(@notification_types, params: {current_user: current_user}).serializable_hash
        end

    end
end