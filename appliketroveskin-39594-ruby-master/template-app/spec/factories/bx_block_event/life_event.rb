FactoryBot.define do
  factory :life_event, :class => 'BxBlockEvent::LifeEvent' do

    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
    info_text { "test123" }
  end
end
