FactoryBot.define do
  factory :skin_hub_view, :class => 'BxBlockContentmanagement::SkinHubView' do

    account_id { 1 }
    objectable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    objectable_type { "BxBlockContentmanagement::LiveVideo" }
  end
end
