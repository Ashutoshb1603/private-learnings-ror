FactoryBot.define do
  factory :klaviyo_list, :class => 'AccountBlock::KlaviyoList' do

    membership_list { 1 }
    not_active_since_6_months { 1 }
    new { true }
    academy { true }
    association :account, factory: :account
    created_at { Time.now }
    updated_at { Time.now }
    non_subscribed_members_list { 1 }
  end
end
