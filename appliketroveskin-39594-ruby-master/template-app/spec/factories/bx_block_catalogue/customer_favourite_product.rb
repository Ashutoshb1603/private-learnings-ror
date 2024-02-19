FactoryBot.define do
  factory :customer_favourite_product, :class => 'BxBlockCatalogue::CustomerFavouriteProduct' do

    account_id { 1 }
    product_id { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    account_type { "test123" }
  end
end
