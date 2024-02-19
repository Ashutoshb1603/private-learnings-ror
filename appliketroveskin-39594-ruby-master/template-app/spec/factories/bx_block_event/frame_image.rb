FactoryBot.define do
  factory :frame_image, :class => 'BxBlockEvent::FrameImage' do

    user_type { "test123" }
    life_event_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
