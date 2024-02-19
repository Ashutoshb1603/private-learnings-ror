namespace :live do
    desc "Live Notifications"
    task notify: :environment do
        start_time = Time.now
        @live_schedule = BxBlockLivestreaming::LiveSchedule.order('at ASC').where('at > ?', start_time).first
        if @live_schedule.present? and (@live_schedule.at - Time.now)/60 <= 30
            time_diff = ((@live_schedule.at - Time.now)/60).to_i
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
            payload_data = {account_ids: accounts.map(&:id), notification_key: 'live_reminder', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'live', key: 'live'}
            BxBlockPushNotifications::FcmSendNotification.new("#{((@live_schedule.at - TIme.now)/60).round} till Skin Deep is live!", "Live scheduled", registration_ids, payload_data).call
        end
    end
end