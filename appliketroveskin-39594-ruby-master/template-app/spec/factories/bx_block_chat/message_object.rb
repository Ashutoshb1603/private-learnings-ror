FactoryBot.define do
  factory :message_object, :class => 'BxBlockChat::MessageObject' do

    object_id { "test123" }
    object_type { "test123" }
    title { "test123" }
    price { 1 }
    variant_id { "test123" }
    image_url { "test123" }
    message_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
