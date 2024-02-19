FactoryBot.define do
  factory :review, :class => 'BxBlockCatalogue::Review' do

    catalogue_id { 1 }
    comment { "test123" }
    rating { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
