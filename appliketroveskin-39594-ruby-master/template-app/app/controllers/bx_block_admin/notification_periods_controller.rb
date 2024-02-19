module BxBlockAdmin
  class NotificationPeriodsController < ApplicationController
    before_action :current_user
    before_action :set_notification_period, only: :update

    def index
      notification_periods = BxBlockNotifications::NotificationPeriod.all
      render json: BxBlockNotifications::NotificationPeriodSerializer.new(notification_periods).serializable_hash,
        status: :ok
    end

    def update
      if @notification_period.update(notification_period_params)
        render json: BxBlockNotifications::NotificationPeriodSerializer.new(@notification_period).serializable_hash,
        status: :ok
      else
        render json: {errors: {message: @notification_period.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    private

    def set_notification_period
      @notification_period = BxBlockNotifications::NotificationPeriod.find(params[:id])
    end

    def notification_period_params
      params.require(:notification_period).permit(:notification_type, :period_type, :period)
    end
  end
end