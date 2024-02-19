FactoryBot.define do
  factory :line_item, :class => 'BxBlockShoppingCart::LineItem' do

    variant_id { "42503800651995" }
    quantity { 1 }
    order_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    sequence(:name) { |n| "Aubergine Lip Pencil #{n}" }
    price { 14.00 }
    total_discount { 1 }
    product_id { "7549054517467" }
    product_image_url { "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/auberginepencil.jpg?v=1645521708" }
  end
end
