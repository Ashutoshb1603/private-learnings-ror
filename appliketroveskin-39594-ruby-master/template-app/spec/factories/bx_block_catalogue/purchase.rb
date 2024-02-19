FactoryBot.define do
  factory :purchase, :class => 'BxBlockCatalogue::Purchase' do

    recommended_product_id { 1 }
    quantity { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
