require 'rails_helper'

describe BxBlockPayments::Payment, :type => :model do
  # let (:subject) { build :bx_block_payments/payment }
  # context "validation" do
  #   it { should validate_presence_of :account }
  # end
  context "associations" do
    it { should belong_to :account }
    # it { should belong_to :plan }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_plan" do
    it "exercises autosave_associated_records_for_plan somehow" do
      subject.autosave_associated_records_for_plan 
    end
  end
  context "create_charge_id" do
    it "exercises create_charge_id somehow" do
      subject.create_charge_id 
    end
  end
  context "set_failed" do
    it "exercises set_failed somehow" do
      subject.set_failed 
    end
  end
  context "set_paid" do
    it "exercises set_paid somehow" do
      subject.set_paid 
    end
  end
  context "set_paypal_executed" do
    it "exercises set_paypal_executed somehow" do
      subject.set_paypal_executed 
    end
  end
  context "set_pending" do
    it "exercises set_pending somehow" do
      subject.set_pending 
    end
  end

end
