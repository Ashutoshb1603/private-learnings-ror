require 'rails_helper'

describe BxBlockShopifyintegration::DiscountCodeUsage, :type => :model do
  # let (:subject) { build :bx_block_shopifyintegration/discount_code_usage }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :order }
  # end
  context "associations" do
    it { should belong_to :account }
    it { should belong_to :order }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_order" do
    it "exercises autosave_associated_records_for_order somehow" do
      subject.autosave_associated_records_for_order 
    end
  end

end
