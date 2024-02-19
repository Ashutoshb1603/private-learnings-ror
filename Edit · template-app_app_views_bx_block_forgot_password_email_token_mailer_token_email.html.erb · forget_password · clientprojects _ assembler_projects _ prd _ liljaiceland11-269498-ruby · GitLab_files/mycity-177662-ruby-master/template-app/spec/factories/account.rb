FactoryBot.define do
  factory :Account, class: 'AccountBlock::Account' do
    email { Faker::Internet.safe_email }
    password {"Abc@12345"}
    user_name { Faker::Name.name }
    full_name { Faker::Name.name }
    phone_number {"9146206197"}
    activated { true }
  end
end