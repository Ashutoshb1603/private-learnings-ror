FactoryBot.define do
  factory :notification_type, :class => 'BxBlockNotifications::NotificationType' do

    title { "test123" }
    description { "test123" }
    key { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
