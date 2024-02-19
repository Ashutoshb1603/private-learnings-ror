FactoryBot.define do
  factory :activity, :class => 'BxBlockCommunityforum::Activity' do

    accountable_id { 1 }
    action { 1 }
    objectable_type { "test123" }
    objectable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    concern_mail_id { 1 }
    accountable_type { "test123" }
  end
end
