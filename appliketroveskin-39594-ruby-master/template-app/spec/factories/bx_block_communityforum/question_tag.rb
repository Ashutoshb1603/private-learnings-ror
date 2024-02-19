FactoryBot.define do
  factory :question_tag, :class => 'BxBlockCommunityforum::QuestionTag' do

    group_id { 1 }
    question_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
