FactoryBot.define do
  factory :recommended_product, :class => 'BxBlockCatalogue::RecommendedProduct' do

    account_id { 1 }
    product_id { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    purchased { true }
    title { "test123" }
    price { 1 }
    parentable_type { 1 }
    parentable_id { 1 }
  end
end
