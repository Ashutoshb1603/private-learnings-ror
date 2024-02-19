FactoryBot.define do
  factory :account,  class: AccountBlock::Account do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    # operator_address { Faker::Name.operator_address }
    email { Faker::Internet.safe_email }
    country_code { '+91' }
    full_phone_number { '+918962418'+rand(100..999).to_s }
    phone_number { 10.times.map { rand(1..9) }.join.to_i }
    activated { true }
  end
end
