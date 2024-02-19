FactoryBot.define do
  factory :product_key, :class => 'BxBlockCatalogue::ProductKey' do

    location { "test123" }
    last_refreshed { Time.now }
  end
end
