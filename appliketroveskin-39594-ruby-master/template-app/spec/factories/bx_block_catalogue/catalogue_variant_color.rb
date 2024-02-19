FactoryBot.define do
  factory :catalogue_variant_color, :class => 'BxBlockCatalogue::CatalogueVariantColor' do

    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
