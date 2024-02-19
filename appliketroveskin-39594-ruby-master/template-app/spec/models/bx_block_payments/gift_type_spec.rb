require 'rails_helper'

describe BxBlockPayments::GiftType, :type => :model do
  # let (:subject) { build :bx_block_payments/gift_type }
  context "validation" do
  end
  context "associations" do
    it { should have_many :wallet_transactions }
    it { should have_one :free_user_image_attachment }
    it { should have_one :free_user_image_blob }
    it { should have_one :gg_user_image_attachment }
    it { should have_one :gg_user_image_blob }
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
  context "autosave_associated_records_for_free_user_image_attachment" do
    it "exercises autosave_associated_records_for_free_user_image_attachment somehow" do
      subject.autosave_associated_records_for_free_user_image_attachment 
    end
  end
  context "autosave_associated_records_for_free_user_image_blob" do
    it "exercises autosave_associated_records_for_free_user_image_blob somehow" do
      subject.autosave_associated_records_for_free_user_image_blob 
    end
  end
  context "autosave_associated_records_for_gg_user_image_attachment" do
    it "exercises autosave_associated_records_for_gg_user_image_attachment somehow" do
      subject.autosave_associated_records_for_gg_user_image_attachment 
    end
  end
  context "autosave_associated_records_for_gg_user_image_blob" do
    it "exercises autosave_associated_records_for_gg_user_image_blob somehow" do
      subject.autosave_associated_records_for_gg_user_image_blob 
    end
  end
  context "autosave_associated_records_for_wallet_transactions" do
    it "exercises autosave_associated_records_for_wallet_transactions somehow" do
      subject.autosave_associated_records_for_wallet_transactions 
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
  context "free_user_image_attachment_id" do
    it "exercises free_user_image_attachment_id somehow" do
      subject.free_user_image_attachment_id 
    end
  end
  context "free_user_image_blob_id" do
    it "exercises free_user_image_blob_id somehow" do
      subject.free_user_image_blob_id 
    end
  end
  context "gg_user_image_attachment_id" do
    it "exercises gg_user_image_attachment_id somehow" do
      subject.gg_user_image_attachment_id 
    end
  end
  context "gg_user_image_blob_id" do
    it "exercises gg_user_image_blob_id somehow" do
      subject.gg_user_image_blob_id 
    end
  end
  context "validate_associated_records_for_wallet_transactions" do
    it "exercises validate_associated_records_for_wallet_transactions somehow" do
      subject.validate_associated_records_for_wallet_transactions 
    end
  end

end
