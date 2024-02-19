FactoryBot.define do
  factory :subscription, :class => 'BxBlockPayments::Subscription' do

    frequency { "monthly" }
    account_id { 1 }
    is_cancelled { false }
    amount { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    next_payment_date { Time.now.to_date }
    payment_from { "test123" }
    currency { 1 }
  end
end
