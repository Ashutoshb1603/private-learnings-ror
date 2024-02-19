FactoryBot.define do
  factory :skin_story, :class => 'BxBlockSkinDiary::SkinStory' do

    sequence(:client_name) { |n| "name#{n}" }
    age { "test123" }
    association :concern, factory: :concern
    description { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end


