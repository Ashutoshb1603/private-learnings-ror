FactoryBot.define do
  factory :message, :class => 'BxBlockChat::Message' do

    chat_id { 1 }
    account_id { 1 }
    message { "test123" }
    is_read { true }
    objectable_type { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    account_type { "test123" }
  end
end
