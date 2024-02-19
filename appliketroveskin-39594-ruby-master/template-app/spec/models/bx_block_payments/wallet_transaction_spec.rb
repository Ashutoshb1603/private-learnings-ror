require 'rails_helper'

describe BxBlockPayments::WalletTransaction, :type => :model do
  # let (:subject) { build :bx_block_payments/wallet_transaction }
  # context "validation" do
  #   it { should validate_presence_of :wallet }
  # end
  context "associations" do
    it { should belong_to :wallet }
    # it { should belong_to :sender }
    # it { should belong_to :receiver }
    # it { should belong_to :gift_type }
  end
  context "autosave_associated_records_for_gift_type" do
    it "exercises autosave_associated_records_for_gift_type somehow" do
      subject.autosave_associated_records_for_gift_type 
    end
  end
  context "autosave_associated_records_for_receiver" do
    it "exercises autosave_associated_records_for_receiver somehow" do
      subject.autosave_associated_records_for_receiver 
    end
  end
  context "autosave_associated_records_for_sender" do
    it "exercises autosave_associated_records_for_sender somehow" do
      subject.autosave_associated_records_for_sender 
    end
  end
  context "autosave_associated_records_for_wallet" do
    it "exercises autosave_associated_records_for_wallet somehow" do
      subject.autosave_associated_records_for_wallet 
    end
  end

end
