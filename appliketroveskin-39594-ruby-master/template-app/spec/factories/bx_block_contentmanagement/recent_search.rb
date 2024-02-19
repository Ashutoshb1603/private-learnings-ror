FactoryBot.define do
  factory :recent_search, :class => 'BxBlockContentmanagement::RecentSearch' do

    search_param { "test123" }
    account_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
