FactoryBot.define do
  factory :discount_code_usage, :class => 'BxBlockShopifyintegration::DiscountCodeUsage' do

    discount_code { "test123" }
    value_type { 1 }
    amount { 1 }
    account_id { 1 }
    order_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
