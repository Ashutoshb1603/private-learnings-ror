require 'rails_helper'

describe BxBlockCoupons::CouponService, :type => :model do
  # let (:subject) { build :bx_block_coupons/coupon_service }
  # context "validation" do
  #   it { should validate_presence_of :coupon }
  #   it { should validate_presence_of :sub_categories }
  # end
  context "associations" do
    it { should belong_to :coupon }
    it { should belong_to :sub_categories }
  end
  context "autosave_associated_records_for_coupon" do
    it "exercises autosave_associated_records_for_coupon somehow" do
      subject.autosave_associated_records_for_coupon 
    end
  end
  context "autosave_associated_records_for_sub_categories" do
    it "exercises autosave_associated_records_for_sub_categories somehow" do
      subject.autosave_associated_records_for_sub_categories 
    end
  end

end
