FactoryBot.define do
  factory :coupon_service, :class => 'BxBlockCoupons::CouponService' do

    sub_categories_id { 1 }
    coupon_id { 1 }
  end
end
