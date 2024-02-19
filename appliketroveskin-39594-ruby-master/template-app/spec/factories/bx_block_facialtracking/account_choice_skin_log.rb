FactoryBot.define do
  factory :account_choice_skin_log, :class => 'BxBlockFacialtracking::AccountChoiceSkinLog' do

    account_id { 1 }
    skin_quiz_id { 1 }
    choice_ids { 1 }
    other { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    account_type { "test123" }
  end
end
