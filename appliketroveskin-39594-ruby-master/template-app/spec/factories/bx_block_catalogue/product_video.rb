FactoryBot.define do
  factory :product_video, :class => 'BxBlockCatalogue::ProductVideo' do

    product_id { "test123" }
    video_url { "https://www.youtube.com/" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
