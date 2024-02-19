FactoryBot.define do
  factory :story_view, :class => 'AccountBlock::StoryView' do

    accountable_id { 1 }
    story_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    accountable_type { "test123" }
  end
end
