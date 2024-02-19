FactoryBot.define do
  factory :order, :class => 'BxBlockShoppingCart::Order' do

    service_provider_id { 1 }
    customer_id { "AccountBlock::Account" }
    address_id { 1 }
    booking_date { Time.now.to_date }
    slot_start_time { "test123" }
    total_fees { "test123" }
    instructions { "test123" }
    service_total_time_minutes { "test123" }
    status { "test123" }
    discount { "test123" }
    coupon_id { 1 }
    is_coupon_applied { true }
    order_type { 1 }
    notify_me { true }
    job_status { true }
    ongoing_time { "test123" }
    finish_at { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    sequence(:email) { |n| "test#{n}@example.com" }
    phone { "+44000000000" }
    financial_status { 1 }
    order_id { "test123" }
    cancel_reason { "test123" }
    cancelled_at { Time.now.to_date }
    subtotal_price { 1 }
    total_price { 1 }
    total_tax { 1 }
    shipping_charges { 1 }
    tax_title { "test123" }
    shipping_title { "test123" }
    requires_shipping { true }
    shipping_id { 1 }
    transaction_id { "test123" }
    currency { 1 }
  end
end
