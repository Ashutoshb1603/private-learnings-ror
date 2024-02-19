FactoryBot.define do
  factory :account_notification_status, :class => 'BxBlockNotifications::AccountNotificationStatus' do

    account_id { 1 }
    notification_type_id { 1 }
    enabled { true }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
