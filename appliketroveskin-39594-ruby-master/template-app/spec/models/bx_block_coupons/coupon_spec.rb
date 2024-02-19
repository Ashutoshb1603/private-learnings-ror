require 'rails_helper'

describe BxBlockCoupons::Coupon, :type => :model do
  # let (:subject) { build :bx_block_coupons/coupon }
  context "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :discount }
    it { should validate_presence_of :coupon_type }
    it { should validate_presence_of :min_order }
    it { should validate_presence_of :status }
    it { should validate_presence_of :max_discount }
    # it "uniqueness_validator test for [:name]"
  end
  context "associations" do
    it { should have_many :coupon_services }
  end
  context "after_add_for_coupon_services" do
    it "exercises after_add_for_coupon_services somehow" do
      subject.after_add_for_coupon_services 
    end
  end
  context "after_add_for_coupon_services=" do
    it "exercises after_add_for_coupon_services= somehow" do
      subject.after_add_for_coupon_services= 1
    end
  end
  context "after_add_for_coupon_services?" do
    it "exercises after_add_for_coupon_services? somehow" do
      subject.after_add_for_coupon_services? 
    end
  end
  context "after_remove_for_coupon_services" do
    it "exercises after_remove_for_coupon_services somehow" do
      subject.after_remove_for_coupon_services 
    end
  end
  context "after_remove_for_coupon_services=" do
    it "exercises after_remove_for_coupon_services= somehow" do
      subject.after_remove_for_coupon_services= 1
    end
  end
  context "after_remove_for_coupon_services?" do
    it "exercises after_remove_for_coupon_services? somehow" do
      subject.after_remove_for_coupon_services? 
    end
  end
  context "autosave_associated_records_for_coupon_services" do
    it "exercises autosave_associated_records_for_coupon_services somehow" do
      subject.autosave_associated_records_for_coupon_services 
    end
  end
  context "before_add_for_coupon_services" do
    it "exercises before_add_for_coupon_services somehow" do
      subject.before_add_for_coupon_services 
    end
  end
  context "before_add_for_coupon_services=" do
    it "exercises before_add_for_coupon_services= somehow" do
      subject.before_add_for_coupon_services= 1
    end
  end
  context "before_add_for_coupon_services?" do
    it "exercises before_add_for_coupon_services? somehow" do
      subject.before_add_for_coupon_services? 
    end
  end
  context "before_remove_for_coupon_services" do
    it "exercises before_remove_for_coupon_services somehow" do
      subject.before_remove_for_coupon_services 
    end
  end
  context "before_remove_for_coupon_services=" do
    it "exercises before_remove_for_coupon_services= somehow" do
      subject.before_remove_for_coupon_services= 1
    end
  end
  context "before_remove_for_coupon_services?" do
    it "exercises before_remove_for_coupon_services? somehow" do
      subject.before_remove_for_coupon_services? 
    end
  end
  context "validate_associated_records_for_coupon_services" do
    it "exercises validate_associated_records_for_coupon_services somehow" do
      subject.validate_associated_records_for_coupon_services 
    end
  end

end
