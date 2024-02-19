FactoryBot.define do
  factory :sms_otp, :class => 'AccountBlock::SmsOtp' do

    full_phone_number { "+919773454625" }
    pin { 1 }
    activated { true }
    valid_until { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
