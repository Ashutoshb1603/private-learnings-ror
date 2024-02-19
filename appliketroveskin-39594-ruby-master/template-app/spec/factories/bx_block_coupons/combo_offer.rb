FactoryBot.define do
  factory :combo_offer, :class => 'BxBlockCoupons::ComboOffer' do

    sequence(:name) { |n| "name#{n}" }
    active { true }
    discount_percentage { 1 }
    sub_title { "test123" }
    offer_end_date { Time.now }
    offer_start_date { Time.now }
    final_price { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
