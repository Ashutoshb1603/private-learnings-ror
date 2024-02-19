FactoryBot.define do
  factory :report, :class => 'BxBlockCommunityforum::Report' do

    reportable_type { "test123" }
    reportable_id { 1 }
    accountable_type { "test123" }
    accountable_id { 1 }
    description { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
