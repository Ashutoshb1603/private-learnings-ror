FactoryBot.define do
  factory :membership_plan, :class => 'BxBlockCustomisableusersubscriptions::MembershipPlan' do

    plan_type { 1 }
    start_date { Time.now }
    end_date { Time.now }
    time_period { 1 }
    account_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
