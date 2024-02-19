FactoryBot.define do
  factory :gift_type, :class => 'BxBlockPayments::GiftType' do

    sequence(:name) { |n| "name#{n}" }
    status { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
