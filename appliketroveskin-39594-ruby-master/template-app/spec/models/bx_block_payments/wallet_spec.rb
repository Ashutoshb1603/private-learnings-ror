require 'rails_helper'

describe BxBlockPayments::Wallet, :type => :model do
  # let (:subject) { build :bx_block_payments/wallet }
  # context "validation" do
  #   it { should validate_presence_of :account }
  # end
  context "associations" do
    it { should belong_to :account }
    it { should have_many :wallet_transactions }
    it { should have_many :senders }
    it { should have_many :receivers }
  end
  context "after_add_for_receivers" do
    it "exercises after_add_for_receivers somehow" do
      subject.after_add_for_receivers 
    end
  end
  context "after_add_for_receivers=" do
    it "exercises after_add_for_receivers= somehow" do
      subject.after_add_for_receivers= 1
    end
  end
  context "after_add_for_receivers?" do
    it "exercises after_add_for_receivers? somehow" do
      subject.after_add_for_receivers? 
    end
  end
  context "after_add_for_senders" do
    it "exercises after_add_for_senders somehow" do
      subject.after_add_for_senders 
    end
  end
  context "after_add_for_senders=" do
    it "exercises after_add_for_senders= somehow" do
      subject.after_add_for_senders= 1
    end
  end
  context "after_add_for_senders?" do
    it "exercises after_add_for_senders? somehow" do
      subject.after_add_for_senders? 
    end
  end
  context "after_add_for_wallet_transactions" do
    it "exercises after_add_for_wallet_transactions somehow" do
      subject.after_add_for_wallet_transactions 
    end
  end
  context "after_add_for_wallet_transactions=" do
    it "exercises after_add_for_wallet_transactions= somehow" do
      subject.after_add_for_wallet_transactions= 1
    end
  end
  context "after_add_for_wallet_transactions?" do
    it "exercises after_add_for_wallet_transactions? somehow" do
      subject.after_add_for_wallet_transactions? 
    end
  end
  context "after_remove_for_receivers" do
    it "exercises after_remove_for_receivers somehow" do
      subject.after_remove_for_receivers 
    end
  end
  context "after_remove_for_receivers=" do
    it "exercises after_remove_for_receivers= somehow" do
      subject.after_remove_for_receivers= 1
    end
  end
  context "after_remove_for_receivers?" do
    it "exercises after_remove_for_receivers? somehow" do
      subject.after_remove_for_receivers? 
    end
  end
  context "after_remove_for_senders" do
    it "exercises after_remove_for_senders somehow" do
      subject.after_remove_for_senders 
    end
  end
  context "after_remove_for_senders=" do
    it "exercises after_remove_for_senders= somehow" do
      subject.after_remove_for_senders= 1
    end
  end
  context "after_remove_for_senders?" do
    it "exercises after_remove_for_senders? somehow" do
      subject.after_remove_for_senders? 
    end
  end
  context "after_remove_for_wallet_transactions" do
    it "exercises after_remove_for_wallet_transactions somehow" do
      subject.after_remove_for_wallet_transactions 
    end
  end
  context "after_remove_for_wallet_transactions=" do
    it "exercises after_remove_for_wallet_transactions= somehow" do
      subject.after_remove_for_wallet_transactions= 1
    end
  end
  context "after_remove_for_wallet_transactions?" do
    it "exercises after_remove_for_wallet_transactions? somehow" do
      subject.after_remove_for_wallet_transactions? 
    end
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_receivers" do
    it "exercises autosave_associated_records_for_receivers somehow" do
      subject.autosave_associated_records_for_receivers 
    end
  end
  context "autosave_associated_records_for_senders" do
    it "exercises autosave_associated_records_for_senders somehow" do
      subject.autosave_associated_records_for_senders 
    end
  end
  context "autosave_associated_records_for_wallet_transactions" do
    it "exercises autosave_associated_records_for_wallet_transactions somehow" do
      subject.autosave_associated_records_for_wallet_transactions 
    end
  end
  context "before_add_for_receivers" do
    it "exercises before_add_for_receivers somehow" do
      subject.before_add_for_receivers 
    end
  end
  context "before_add_for_receivers=" do
    it "exercises before_add_for_receivers= somehow" do
      subject.before_add_for_receivers= 1
    end
  end
  context "before_add_for_receivers?" do
    it "exercises before_add_for_receivers? somehow" do
      subject.before_add_for_receivers? 
    end
  end
  context "before_add_for_senders" do
    it "exercises before_add_for_senders somehow" do
      subject.before_add_for_senders 
    end
  end
  context "before_add_for_senders=" do
    it "exercises before_add_for_senders= somehow" do
      subject.before_add_for_senders= 1
    end
  end
  context "before_add_for_senders?" do
    it "exercises before_add_for_senders? somehow" do
      subject.before_add_for_senders? 
    end
  end
  context "before_add_for_wallet_transactions" do
    it "exercises before_add_for_wallet_transactions somehow" do
      subject.before_add_for_wallet_transactions 
    end
  end
  context "before_add_for_wallet_transactions=" do
    it "exercises before_add_for_wallet_transactions= somehow" do
      subject.before_add_for_wallet_transactions= 1
    end
  end
  context "before_add_for_wallet_transactions?" do
    it "exercises before_add_for_wallet_transactions? somehow" do
      subject.before_add_for_wallet_transactions? 
    end
  end
  context "before_remove_for_receivers" do
    it "exercises before_remove_for_receivers somehow" do
      subject.before_remove_for_receivers 
    end
  end
  context "before_remove_for_receivers=" do
    it "exercises before_remove_for_receivers= somehow" do
      subject.before_remove_for_receivers= 1
    end
  end
  context "before_remove_for_receivers?" do
    it "exercises before_remove_for_receivers? somehow" do
      subject.before_remove_for_receivers? 
    end
  end
  context "before_remove_for_senders" do
    it "exercises before_remove_for_senders somehow" do
      subject.before_remove_for_senders 
    end
  end
  context "before_remove_for_senders=" do
    it "exercises before_remove_for_senders= somehow" do
      subject.before_remove_for_senders= 1
    end
  end
  context "before_remove_for_senders?" do
    it "exercises before_remove_for_senders? somehow" do
      subject.before_remove_for_senders? 
    end
  end
  context "before_remove_for_wallet_transactions" do
    it "exercises before_remove_for_wallet_transactions somehow" do
      subject.before_remove_for_wallet_transactions 
    end
  end
  context "before_remove_for_wallet_transactions=" do
    it "exercises before_remove_for_wallet_transactions= somehow" do
      subject.before_remove_for_wallet_transactions= 1
    end
  end
  context "before_remove_for_wallet_transactions?" do
    it "exercises before_remove_for_wallet_transactions? somehow" do
      subject.before_remove_for_wallet_transactions? 
    end
  end
  context "validate_associated_records_for_receivers" do
    it "exercises validate_associated_records_for_receivers somehow" do
      subject.validate_associated_records_for_receivers 
    end
  end
  context "validate_associated_records_for_senders" do
    it "exercises validate_associated_records_for_senders somehow" do
      subject.validate_associated_records_for_senders 
    end
  end
  context "validate_associated_records_for_wallet_transactions" do
    it "exercises validate_associated_records_for_wallet_transactions somehow" do
      subject.validate_associated_records_for_wallet_transactions 
    end
  end

end
