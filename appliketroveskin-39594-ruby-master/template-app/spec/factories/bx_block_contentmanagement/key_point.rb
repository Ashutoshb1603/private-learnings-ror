FactoryBot.define do
  factory :key_point, :class => 'BxBlockContentmanagement::KeyPoint' do

    description { "test123" }
    academy_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
