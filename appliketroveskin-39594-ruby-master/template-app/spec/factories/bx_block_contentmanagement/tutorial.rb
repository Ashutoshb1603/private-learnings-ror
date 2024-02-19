FactoryBot.define do
  factory :tutorial, :class => 'BxBlockContentmanagement::Tutorial' do

    title { "test123" }
    description { "test123" }
    url { "https://www.goggle.com" }
    # group_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    association :group, factory: :group
  end
end
