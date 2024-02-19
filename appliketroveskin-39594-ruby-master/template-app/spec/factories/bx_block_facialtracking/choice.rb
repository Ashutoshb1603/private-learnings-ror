FactoryBot.define do
  factory :choice, :class => 'BxBlockFacialtracking::Choice' do

    choice { "test123" }
    skin_quiz_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    active { true }
  end
end
