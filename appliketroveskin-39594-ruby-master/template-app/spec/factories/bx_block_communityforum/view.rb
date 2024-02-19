FactoryBot.define do
  factory :view, :class => 'BxBlockCommunityforum::View' do

    accountable_id { 1 }
    question_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    accountable_type { "test123" }
  end
end
