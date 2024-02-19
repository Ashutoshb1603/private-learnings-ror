FactoryBot.define do
  factory :category, :class => 'BxBlockCategories::Category' do

    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
