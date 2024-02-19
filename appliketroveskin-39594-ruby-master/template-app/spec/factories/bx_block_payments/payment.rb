FactoryBot.define do
  factory :payment, :class => 'BxBlockPayments::Payment' do

    plan_id { 1 }
    account_id { 1 }
    status { 1 }
    token { "test123" }
    charge_id { "test123" }
    error_message { "test123" }
    customer_id { "test123" }
    payment_gateway { 1 }
    price_cents { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    added_in_wallet { true }
    refunded_amount { 1 }
    currency { 1 }
  end
end
