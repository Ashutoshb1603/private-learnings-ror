FactoryBot.define do
  factory :coupon, :class => 'BxBlockCoupons::Coupon' do

    sequence(:name) { |n| "name#{n}" }
    discount { 1 }
    coupon_type { 1 }
    min_order { "test123" }
    status { 1 }
    max_discount { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
