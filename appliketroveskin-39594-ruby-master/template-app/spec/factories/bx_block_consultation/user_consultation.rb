FactoryBot.define do
  factory :user_consultation, :class => 'BxBlockConsultation::UserConsultation' do

    sequence(:name) { |n| "name#{n}" }
    phone_number { "+44000000000" }
    address { "test123" }
    age { 1 }
    sequence(:email) { |n| "test#{n}@example.com" }
    account_id { 1 }
    therapist_id { 1 }
    booked_datetime { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
