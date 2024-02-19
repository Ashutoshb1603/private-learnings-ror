FactoryBot.define do
  factory :catalogue, :class => 'BxBlockCatalogue::Catalogue' do

    category_id { 1 }
    sub_category_id { 1 }
    sequence(:name) { |n| "name#{n}" }
    sku { "test123" }
    description { "test123" }
    manufacture_date { Time.now }
    length { "test123" }
    breadth { "test123" }
    height { "test123" }
    availability { 1 }
    stock_qty { 1 }
    weight { 1 }
    price { "test123" }
    recommended { true }
    on_sale { true }
    sale_price { 1 }
    discount { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    block_qty { 1 }
    trait "with_brand" do
      association :brand, factory: :brand
    end
  end
end
