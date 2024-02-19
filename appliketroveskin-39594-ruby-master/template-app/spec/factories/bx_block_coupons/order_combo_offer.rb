FactoryBot.define do
  factory :order_combo_offer, :class => 'BxBlockCoupons::OrderComboOffer' do

    order_id { 1 }
    combo_offer_id { 1 }
  end
end
