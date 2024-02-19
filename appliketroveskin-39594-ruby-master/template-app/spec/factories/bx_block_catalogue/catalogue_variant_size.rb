FactoryBot.define do
  factory :catalogue_variant_size, :class => 'BxBlockCatalogue::CatalogueVariantSize' do

    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
