FactoryBot.define do
  factory :product_collection_view, :class => 'BxBlockCatalogue::ProductCollectionView' do

    collection_id { "test123" }
    accountable_type { "test123" }
    accountable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
