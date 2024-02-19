module BxBlockLivestreaming
    class LiveScheduleController < ApplicationController

        before_action :validate_json_web_token
        before_action :get_user 
        before_action :validate_admin

        def index
            start_time = 5.minutes.ago
            @live_schedules = LiveSchedule.order('at ASC').where('at > ?', start_time)
            render json: LiveScheduleSerializer.new(@live_schedules, meta: {
                total_count: @live_schedules.count
            }).serializable_hash, status: :ok
        end

        def create
            @live_schedule = LiveSchedule.new(live_schedule_params)
            if @live_schedule.save
                if @live_schedule.event_creation_notification
                    if @live_schedule.user_type == "all"
                        accounts = AccountBlock::Account.all
                    elsif @live_schedule.user_type == "elite_and_glow_getters"
                        accounts = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ?', Time.now)
                    elsif @live_schedule.user_type == "free"
                        accounts = AccountBlock::Account.left_joins(:membership_plans).where('membership_plans.id IS NULL or membership_plans.end_date < ?', Time.now)
                    else
                        plan_type_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types[@live_schedule.user_type]
                        accounts = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, plan_type_value)
                    end
                    # accounts = accounts.where("accounts.email != ?", live_schedule_params[:guest_email]) if live_schedule_params[:guest_email].present?
                    if live_schedule_params[:guest_email].present?
                        guest_account = AccountBlock::Account.find_by(email: live_schedule_params[:guest_email])
                        guest_account_token = guest_account['device_token'] if guest_account.present?
                        payload_data = {account: guest_account, notification_key: 'calendar', inapp: true, push_notification: true, type: 'skin_hub', notification_for: 'live', key: 'live', redirect: 'calendar', record_id: @live_schedule&.id}
                        BxBlockPushNotifications::FcmSendNotification.new("You've been invited to join a live video at #{@live_schedule.at.in_time_zone('Europe/Dublin').strftime('%d %b %Y %I:%M %p')}!", "Skin Deep scheduled a live", guest_account_token, payload_data).call
                    end
                    registration_ids = accounts.map(&:device_token)
                    payload_data = {account_ids: accounts.map(&:id), notification_key: 'calendar', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'live', key: 'live', redirect: 'calendar', record_id: @live_schedule&.id}
                    BxBlockPushNotifications::FcmSendNotification.new("Skin Deep will be live at #{@live_schedule.at.in_time_zone('Europe/Dublin').strftime('%d %b %Y %I:%M %p')}!", "Skin Deep scheduled a live", registration_ids, payload_data).call
                end
                render json: LiveScheduleSerializer.new(@live_schedule, meta: {
                    message: "Live scheduled successfully."}).serializable_hash, status: :created
            else
                render json: {errors: {message: @live_schedule.errors.full_messages}},
                       status: :unprocessable_entity
            end
        end

        def destroy
            @live_schedule = LiveSchedule.find(params[:id])
            if @live_schedule.user_type == "all"
                accounts = AccountBlock::Account.all
            elsif @live_schedule.user_type == "elite_and_glow_getters"
                accounts = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ?', Time.now)
            elsif @live_schedule.user_type == "free"
                accounts = AccountBlock::Account.left_joins(:membership_plans).where('membership_plans.id IS NULL or membership_plans.end_date < ?', Time.now)
            else
                plan_type_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types[@live_schedule.user_type]
                accounts = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, plan_type_value)
            end
            registration_ids = accounts.map(&:device_token)
            payload_data = {account_ids: accounts.map(&:id), notification_key: 'live_scheduled_cancelled', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'live', key: 'live'}
            if @live_schedule.destroy
                BxBlockPushNotifications::FcmSendNotification.new("Skin Deep cancelled scheduled live for #{@live_schedule.at.strftime('%d %b %Y %I:%M %p')}!", "Skin Deep scheduled live is cancelled", registration_ids, payload_data).call
                render json: {message: "Live schedule deleted successfully."}, status: :ok
            else
                render json: {errors: {message: @live_schedule.errors.full_messages}},
                          status: :unprocessable_entity
            end
        end

        def update
            @live_schedule = LiveSchedule.find(params[:id])
            if @live_schedule.update(live_schedule_params)
                render json: LiveScheduleSerializer.new(@live_schedule, meta: {
                    message: "Live schedule updated successfully."}).serializable_hash, status: :ok
            else
                render json: {errors: {message: @live_schedule.errors.full_messages}},
                          status: :unprocessable_entity
            end
        end

        private

        def live_schedule_params
            params["data"].require(:attributes).permit(:at, :event_creation_notification, :reminder_notification, :user_type, :guest_email)
        end

        def get_user
            @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            @account
        end

        def validate_admin
            errors = []
            errors = ['Account is not associated to an admin'] unless @account.type == "AdminAccount"
            render json: {errors: errors} unless errors.empty?
        end

    end
end
