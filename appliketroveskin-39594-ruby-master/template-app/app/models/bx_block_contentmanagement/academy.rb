require 'redis'
module BxBlockContentmanagement
    class Academy < ApplicationRecord
        self.table_name = :academies

        has_many :academy_videos, class_name: 'BxBlockContentmanagement::AcademyVideo', dependent: :destroy
        has_many :customer_academy_subscriptions, class_name: 'BxBlockContentmanagement::CustomerAcademySubscription', dependent: :destroy
        has_many :key_points, class_name: 'BxBlockContentmanagement::KeyPoint', dependent: :destroy

        accepts_nested_attributes_for :academy_videos, allow_destroy: true
        accepts_nested_attributes_for :key_points, allow_destroy: true
        after_create :send_notification
        has_one_attached :image

        def send_notification
            accounts = AccountBlock::Account.where("device_token is not null and device_token != ''")
            registration_ids = accounts.map(&:device_token)
            data = {
                notification_type: "academy_video",
                id: self.id
            }
            payload_data = {account: @user, account_ids: accounts.map(&:id), notification_key: 'course_created', inapp: true, push_notification: true, all: true, type: 'skin_hub', redirect: 'academy_video', record_id: self.id, notification_for: 'academy', key: 'academy'}
            BxBlockPushNotifications::FcmSendNotification.new("We have just issued a new masterclass in our training academy. Be one of the first to view by downloading here.", "New training academy course is added", registration_ids, payload_data, data).call if self.title.present?
            email_ids = AccountBlock::Account.where("email is not null and email != ''").map(&:email)
            redis = Redis.new(host: 'localhost')
            redis.set("emails", email_ids)
            BxBlockContentmanagement::SendMailsWorker.perform_async(self.title)
        end
    end
end
