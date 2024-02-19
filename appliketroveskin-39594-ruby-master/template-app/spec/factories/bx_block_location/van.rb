FactoryBot.define do
  factory :van, :class => 'BxBlockLocation::Van' do

    sequence(:name) { |n| "name#{n}" }
    bio { "test123" }
    is_offline { true }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
