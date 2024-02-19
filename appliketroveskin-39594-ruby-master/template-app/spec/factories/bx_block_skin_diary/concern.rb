FactoryBot.define do
  factory :concern, :class => 'BxBlockSkinDiary::Concern' do

    title { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
