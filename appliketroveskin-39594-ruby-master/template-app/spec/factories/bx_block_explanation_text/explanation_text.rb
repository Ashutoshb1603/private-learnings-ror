FactoryBot.define do
  factory :explanation_text, :class => 'BxBlockExplanationText::ExplanationText' do

    sequence(:section_name) { |n| "name#{n}" }
    value { "test123" }
    sequence(:area_name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
