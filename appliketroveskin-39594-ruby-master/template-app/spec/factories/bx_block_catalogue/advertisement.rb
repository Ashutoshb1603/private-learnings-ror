FactoryBot.define do
  factory :advertisement, :class => BxBlockCatalogue::Advertisement do

    url { "https://google.com" }
    active { true }
    created_at { Time.now }
    updated_at { Time.now }
    dimension { "347 * 100" }
    product_id { "test123" }
    country {"Ireland"}
    title { "test123" }
    appointment_id { "8551200" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.jpeg'), 'image/jpeg') }
  end
end
