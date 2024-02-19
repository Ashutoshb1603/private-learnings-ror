module BxBlockNotifications
  class NotificationsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    @@silent_job = BxBlockNotifications::SilentNotificationJob
    before_action :current_user

    def index
      # @notifications = current_user.notifications.where('created_at >= ?', 15.days.before.beginning_of_day).order('created_at DESC')
      @notifications = current_user.notifications.order('created_at DESC')
      unread_count = current_user&.notifications&.unread.count
      if @notifications.present?
        render json: NotificationSerializer.new(@notifications, params: {current_user: @current_user}).serializable_hash.merge(unread_count: unread_count, meta: {
            message: "List of notifications."}), status: :ok
      else
        render json: {data:[], unread_count:0, meta: {message: "List of notifications."}}, status: :ok
      end
    end

    def show
      @notification = Notification.find(params[:id])
      @notification.update(is_read: true, read_at: Time.now) unless @notification.is_read
      @@silent_job.perform_now(@current_user, false)
      render json: NotificationSerializer.new(@notification, params: {current_user: @current_user}, meta: {
          message: "Success."}).serializable_hash, status: :ok
    end

    def create
      @notification = Notification.new(notification_paramas)
      if @notification.save
        render json: NotificationSerializer.new(@notification, params: {current_user: @current_user}, meta: {
            message: "Notification created."}).serializable_hash, status: :created
      else
        render json: {errors: {message: @notification.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def update
      @notification = Notification.find(params[:id])
      if @notification.update(is_read: true, read_at: DateTime.now)
        render json: NotificationSerializer.new(@notification, params: {current_user: @current_user}, meta: {
          message: "Notification marked as read."}).serializable_hash, status: :ok
      else
        render json: {errors: {message: @notification.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def destroy
      @notification = Notification.find(params[:id])
      if @notification.destroy
        @@silent_job.perform_now(@current_user, false)
        render json: {message: "Deleted."}, status: :ok
      else
        render json: {errors: {message: @notification.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def read_all
      @notifications = current_user.notifications.where(is_read: false)
      if @notifications.update_all(is_read: true, read_at: DateTime.now)
        @@silent_job.perform_now(@current_user, false)
        render json: {message: "All notifications marked as read."}, status: :ok
      else
        render json: {errors: {message: @notifications.errors.full_messages}},
                status: :unprocessable_entity
      end
    end

    def delete_all
      @notifications = current_user.notifications
      if @notifications.destroy_all
        @@silent_job.perform_now(@current_user, false)
        render json: {message: "All notifications deleted."}, status: :ok
      else
        render json: {errors: {message: @notifications.errors.full_messages}},
                status: :unprocessable_entity
      end
    end

    def user_notifications(room_name="", user_type="all", notification_type="admin", title="", description="", guest_email="", sid="")
      notifications = []
      accounts = AccountBlock::Account.all if user_type == "all"
      accounts = AccountBlock::Account.joins(customer_academy_subscriptions).uniq if user_type == "academy"
      accounts = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ?', Time.now) if user_type == "elite_and_glow_getters"
      accounts = AccountBlock::Account.left_joins(:membership_plans).where('membership_plans.id IS NULL or membership_plans.end_date < ?', Time.now) if user_type == "free"
      accounts = AccountBlock::Account.joins(:role).where('lower(roles.name) = ?', 'therapist') if user_type == "therapists"
      accounts = AccountBlock::Account.where('lower(email) = ?', guest_email) if user_type == "customer"
      if user_type == "elite" || user_type == "glow_getter"
        plan_type_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types[user_type]
        accounts = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, plan_type_value)
      end

      guest_message = description
      guest_message = "You've been invited to join a live video." if notification_type == "live_streaming"

      guest_account = AccountBlock::Account.where('LOWER(email) = ?', guest_email.downcase).first
      notification = guest_account.notifications.create(headings: title, contents: guest_message, notification_type: notification_type, room_name: room_name, user_type: 'guest', sid: sid) if guest_account.present? && (notification_type != "live_streaming" || guest_account.role.name.downcase == "therapist" || guest_account.role.name.downcase == "user")
      send_notification(title, guest_message, [guest_account&.device_token], room_name, notification_type, "guest", sid) if guest_account.present? && (notification_type != "live_streaming" || guest_account.role.name.downcase == "therapist" || guest_account.role.name.downcase == "user")

      notification_key = BxBlockNotifications::NotificationType.find_or_create_by(key: 'live')
      disabled_account_ids = notification_key&.account_notification_statuses&.where(enabled: false).pluck(:account_id)
      accounts = accounts.where.not(id: disabled_account_ids)

      accounts.each do |account|
        notification = account.notifications.create(headings: title, contents: description, notification_type: notification_type, room_name: room_name, sid: sid, type_by_user: 'admin_live') unless guest_account == account
        notification.persisted? ? notifications << notification : @errors = notification.errors.full_messages.join(", ") unless guest_account == account
      end
      
      if notifications.present?
        # Sending Push notifications
        registration_ids = accounts.map(&:device_token)
        send_notification(title, description, registration_ids, room_name, notification_type, "user", sid)
      end
    end

    private

    def send_notification(title, description, registration_ids, room_name="", notification_type="admin", user_type="user", sid="")
      fcm = FCM.new(ENV["FIREBASE_SERVER_KEY"])
      options = { "notification":
                   {
                      "title": title,
                      "body": description
                   },
                   "data": {
                     "room_name": room_name,
                     "notification_type": notification_type,
                     "user_type": user_type,
                     "sid": sid
                   }
                  }
      response = fcm.send(registration_ids, options)
    end

    def notification_paramas
      params.require(:notification).permit(
        :headings, :contents, :app_url, :account_id
      ).merge(created_by: @current_user.id, accountable: @current_user)
    end

  end
end
