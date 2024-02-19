FactoryBot.define do
  factory :cart_item, :class => 'BxBlockShoppingCart::CartItem' do

    variant_id { "test123" }
    quantity { 1 }
    account_id { 1 }
    sequence(:name) { |n| "name#{n}" }
    price { 1 }
    product_id { "test123" }
    product_image_url { "test123@example.com" }
    total_price { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
