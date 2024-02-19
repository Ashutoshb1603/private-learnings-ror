FactoryBot.define do
  factory :user_image, :class => 'BxBlockFacialtracking::UserImage' do

    position { "front" }
    account_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    account_type { "test123" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.jpeg'), 'image/jpeg') }
  end
end
