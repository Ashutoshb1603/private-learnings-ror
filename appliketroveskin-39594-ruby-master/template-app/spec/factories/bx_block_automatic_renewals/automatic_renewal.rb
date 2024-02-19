FactoryBot.define do
  factory :automatic_renewal, :class => 'BxBlockAutomaticRenewals::AutomaticRenewal' do

    account_id { 1 }
    subscription_type { "test123" }
    is_auto_renewal { true }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
