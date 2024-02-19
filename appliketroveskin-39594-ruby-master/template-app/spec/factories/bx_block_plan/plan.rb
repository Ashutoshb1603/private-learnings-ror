FactoryBot.define do
  factory :plan, :class => 'BxBlockPlan::Plan' do

    price { 1 }
    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
    duration { 1 }
    period { 1 }
  end
end
