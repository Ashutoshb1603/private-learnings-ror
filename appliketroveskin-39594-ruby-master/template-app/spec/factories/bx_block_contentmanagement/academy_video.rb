FactoryBot.define do
  factory :academy_video, :class => 'BxBlockContentmanagement::AcademyVideo' do

    title { "test123" }
    description { "test123" }
    url { "test123" }
    academy_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
