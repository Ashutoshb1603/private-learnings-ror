FactoryBot.define do
  factory :notification_schedule, :class => 'BxBlockNotifications::NotificationSchedule' do

    title { "test123" }
    message { "test123" }
    at { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
