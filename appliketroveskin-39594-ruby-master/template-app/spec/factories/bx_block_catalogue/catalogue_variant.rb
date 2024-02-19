FactoryBot.define do
  factory :catalogue_variant, :class => 'BxBlockCatalogue::CatalogueVariant' do

    catalogue_id { 1 }
    catalogue_variant_color_id { 1 }
    catalogue_variant_size_id { 1 }
    price { 1 }
    stock_qty { 1 }
    on_sale { true }
    sale_price { 1 }
    discount_price { 1 }
    length { "test123" }
    breadth { "test123" }
    height { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    block_qty { 1 }
  end
end
