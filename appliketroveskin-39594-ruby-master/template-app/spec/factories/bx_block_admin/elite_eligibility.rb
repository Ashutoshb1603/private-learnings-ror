FactoryBot.define do
  factory :elite_eligibility, :class => 'BxBlockAdmin::EliteEligibility' do

    interval { 1 }
    time { 1 }
    eligibility_on { 1 }
    product_type { "test123" }
    value { 1 }
    frequency { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
