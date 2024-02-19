FactoryBot.define do
  factory :skin_hub_like, :class => 'BxBlockContentmanagement::SkinHubLike' do

    account_id { 1 }
    objectable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    objectable_type { "test123" }
  end
end
