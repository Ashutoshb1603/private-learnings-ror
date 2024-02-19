FactoryBot.define do
  factory :skin_quiz, :class => 'BxBlockFacialtracking::SkinQuiz' do

    question { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    sequence(:seq_no) { |n| "1234#{n}".to_i }
    active { true }
    question_type { "sign_up" }
    allows_multiple { true }
    info_text { "test123" }
    short_text { "test123" }
    acuity_field_id { "test123" }
  end
end
