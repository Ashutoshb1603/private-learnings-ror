FactoryBot.define do
  factory :live_schedule, :class => 'BxBlockLivestreaming::LiveSchedule' do

    at { Time.now }
    sequence(:guest_email) { |n| "test#{n}@example.com" }
    user_type { "test123" }
    event_creation_notification { true }
    reminder_notification { true }
    status { 1 }
    sequence(:room_name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
