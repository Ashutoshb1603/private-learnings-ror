FactoryBot.define do
  factory :sms_account, :class => 'AccountBlock::SmsAccount' do

    full_phone_number { "+919773454625" }
    country_code { 1 }
    phone_number { 1 }
    activated { true }
    device_id { "test123" }
    unique_auth_id { "test123" }
    password {'test123'}
    password_confirmation {'test123'}
    type { "EmailAccount" }
    created_at { Time.now }
    updated_at { Time.now }
    association :role, factory: :role
    sequence(:first_name) { |n| "name#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    is_deleted { true }
    is_subscribed_to_mailing { true }
    gender { "male" }
    sign_in_count { 1 }
    jwt_token { "test123" }
    device_token { "test123" }
    device { "android" }
    stripe_customer_id { "test123" }
    sequence(:acuity_calendar) { |n| "test#{n}" }
    sequence(:last_name) { |n| "name#{n}" }
    freeze_account { true }
    age { 1 }
    location { "test123" }
    paypal_customer_id { "test123" }
    blocked { true }
    is_pinned { true }
    last_update_log { Time.now.to_date }
    last_notification { Time.now.to_date }

    trait "with_therapist_role" do
      association :role, :with_therapist
    end
    trait "with_user_role" do
      association :role, :with_user
    end
  end
end
