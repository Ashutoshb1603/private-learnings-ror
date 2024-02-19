FactoryBot.define do
  factory :hero_product, :class => 'BxBlockCatalogue::HeroProduct' do

    tags_type { 1 }
    title { "test123" }
    tags { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
