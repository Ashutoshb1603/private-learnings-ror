FactoryBot.define do
  factory :email_account, :class => 'AccountBlock::EmailAccount' do

    full_phone_number { "+919778546878" }
    country_code { 1 }
    phone_number { 1 }
    sequence(:email) { |n| "email_test#{n}@example.com" }
    activated { true }
    device_id { "test123" }
    unique_auth_id { "test123" }
    password {'test123'}
    password_confirmation {'test123'}
    created_at { Time.now }
    updated_at { Time.now }
    role_id { 1 }
    sequence(:first_name) { |n| "name#{n}" }
    is_deleted { false }
    is_subscribed_to_mailing { true }
    gender { "male" }
    sign_in_count { 1 }
    jwt_token { "test123" }
    device_token { "daNHbQUuTde-SAU3WW4EGu:APA91bFmvB8UDX-q3Bnl92y8SqXhfQwKTuRRVLbtU_Vy91hYL1k5A7fjZpjD4IQcX08IuaG_sSdw2vbReaYYg8TUuONQROMsDbSsH5wNc_KwMpSCbayKNaQrRIXs5EkimAEQOrclU-wE" }
    device { "android" }
    stripe_customer_id { "test123" }
    sequence (:acuity_calendar) { |n| "1234534#{n}" }
    sequence(:last_name) { |n| "name#{n}" }
    freeze_account { false }
    age { 1 }
    location  { "test123" }
    paypal_customer_id { "test123" }
    blocked { false }
    is_pinned { false }
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