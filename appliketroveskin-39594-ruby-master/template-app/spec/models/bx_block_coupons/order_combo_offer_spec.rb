require 'rails_helper'

describe BxBlockCoupons::OrderComboOffer, :type => :model do
  # let (:subject) { build :bx_block_coupons/order_combo_offer }
  # context "validation" do
  #   it { should validate_presence_of :combo_offer }
  #   it { should validate_presence_of :order }
  # end
  context "associations" do
    it { should belong_to :combo_offer }
    it { should belong_to :order }
  end
  context "autosave_associated_records_for_combo_offer" do
    it "exercises autosave_associated_records_for_combo_offer somehow" do
      subject.autosave_associated_records_for_combo_offer 
    end
  end
  context "autosave_associated_records_for_order" do
    it "exercises autosave_associated_records_for_order somehow" do
      subject.autosave_associated_records_for_order 
    end
  end

end
