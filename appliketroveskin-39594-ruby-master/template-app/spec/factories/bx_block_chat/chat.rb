FactoryBot.define do
  factory :chat, :class => 'BxBlockChat::Chat' do

    account_id { 1 }
    status { 1 }
    start_date { Time.now }
    end_date { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
    therapist_id { 1 }
    pinned { true }
    sid { "test123" }
    therapist_type { "test123" }
  end
end
