FactoryBot.define do
  factory :contact, class: "BxBlockContactUs::Contact" do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    phone_number { '919876543212' }
  end
end