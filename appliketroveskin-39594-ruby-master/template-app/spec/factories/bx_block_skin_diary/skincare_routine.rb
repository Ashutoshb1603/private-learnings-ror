FactoryBot.define do
  factory :skincare_routine, :class => 'BxBlockSkinDiary::SkincareRoutine' do

    therapist_id { 1 }
    account_id { 1 }
    routine_type { 1 }
    note { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    therapist_type { "test123" }
    account_type { "test123" }
  end
end
