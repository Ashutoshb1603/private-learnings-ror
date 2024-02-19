FactoryBot.define do
  factory :question, :class => 'BxBlockCommunityforum::Question' do

    title { "test123" }
    description { "test123" }
    status { 1 }
    accountable_id { 1 }
    anonymous { true }
    created_at { Time.now }
    updated_at { Time.now }
    offensive { true }
    user_type { 1 }
    accountable_type { "test123" }
    recommended { true }
  end
end
