FactoryBot.define do
  factory :therapist_note, :class => 'AccountBlock::TherapistNote' do

    therapist_id { 1 }
    account_id { 1 }
    description { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    therapist_type { "test123" }
  end
end
