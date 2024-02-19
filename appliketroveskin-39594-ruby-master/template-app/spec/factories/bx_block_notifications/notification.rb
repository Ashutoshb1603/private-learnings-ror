FactoryBot.define do
  factory :notification, :class => 'BxBlockNotifications::Notification' do

    created_by { 1 }
    headings { "test123" }
    contents { "test123" }
    app_url { "test123" }
    is_read { true }
    read_at { Time.now }
    accountable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    sequence(:room_name) { |n| "name#{n}" }
    notification_type { 1 }
    user_type { 1 }
    sid { "test123" }
    type_by_user { "test123" }
    accountable_type { "test123" }
    redirect { "test123" }
    record_id { "test123" }
    notification_for { "test123" }
    parent_id { "test123" }
    purchased { true }
  end
end
