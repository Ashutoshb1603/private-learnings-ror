FactoryBot.define do
  factory :skincare_product, :class => 'BxBlockSkinDiary::SkincareProduct' do

    sequence(:name) { |n| "name#{n}" }
    product_id { "test123" }
    skincare_step_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    image_url { "test123" }
  end
end
