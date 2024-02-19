FactoryBot.define do
  factory :live_video, :class => 'BxBlockContentmanagement::LiveVideo' do

    title { "test123" }
    description { "test123" }
    url { "test123" }
    group_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    status { 1 }
    room_sid { "test123" }
    composition_sid { "test123" }
  end
end
