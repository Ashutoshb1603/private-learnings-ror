FactoryBot.define do
  factory :email_otp, :class => 'AccountBlock::EmailOtp' do

    sequence(:email) { |n| "test#{n}@example.com" }
    pin { 1 }
    activated { true }
    valid_until { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
