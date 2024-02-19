FactoryBot.define do
  factory :like, :class => 'BxBlockCommunityforum::Like' do

    accountable_id { 1 }
    objectable_type { "test123" }
    objectable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    accountable_type { "test123" }
  end
end
