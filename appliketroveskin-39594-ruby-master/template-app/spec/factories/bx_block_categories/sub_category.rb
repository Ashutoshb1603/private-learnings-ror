FactoryBot.define do
  factory :sub_category, :class => 'BxBlockCategories::SubCategory' do

    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
