FactoryBot.define do
  factory :comment, :class => 'BxBlockCommunityforum::Comment' do

    description { "test123" }
    objectable_type { "test123" }
    objectable_id { 1 }
    accountable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    offensive { true }
    accountable_type { "test123" }
  end
end
