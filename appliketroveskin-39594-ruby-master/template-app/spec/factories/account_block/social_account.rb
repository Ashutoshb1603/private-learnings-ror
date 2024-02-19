FactoryBot.define do
  factory :social_account, :class => 'AccountBlock::SocialAccount' do

    full_phone_number { "+44000000000" }
    country_code { 1 }
    phone_number { 1 }
    sequence(:email) { |n| "test#{n}@example.com" }
    activated { true }
    device_id { "test123" }
    unique_auth_id { "test123" }
    password_digest { "test123" }
    type { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    role_id { 1 }
    sequence(:first_name) { |n| "name#{n}" }
    is_deleted { true }
    is_subscribed_to_mailing { true }
    gender { "test123" }
    sign_in_count { 1 }
    jwt_token { "test123" }
    device_token { "test123" }
    device { "test123" }
    stripe_customer_id { "test123" }
    acuity_calendar { "test123" }
    sequence(:last_name) { |n| "name#{n}" }
    freeze_account { true }
    age { 1 }
    location { "test123" }
    paypal_customer_id { "test123" }
    blocked { true }
    is_pinned { true }
    last_update_log { Time.now.to_date }
    last_notification { Time.now.to_date }
  end
end
