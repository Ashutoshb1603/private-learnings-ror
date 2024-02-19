require 'rails_helper'

describe BxBlockCatalogue::RecommendedProduct, :type => :model do
  # let (:subject) { build :bx_block_catalogue/recommended_product }
  # context "validation" do
  #   it { should validate_presence_of :account }
  # end
  context "associations" do
    it { should belong_to :account }
    # it { should belong_to :parentable }
    it { should have_many :purchases }
  end
  context "after_add_for_purchases" do
    it "exercises after_add_for_purchases somehow" do
      subject.after_add_for_purchases 
    end
  end
  context "after_add_for_purchases=" do
    it "exercises after_add_for_purchases= somehow" do
      subject.after_add_for_purchases= 1
    end
  end
  context "after_add_for_purchases?" do
    it "exercises after_add_for_purchases? somehow" do
      subject.after_add_for_purchases? 
    end
  end
  context "after_remove_for_purchases" do
    it "exercises after_remove_for_purchases somehow" do
      subject.after_remove_for_purchases 
    end
  end
  context "after_remove_for_purchases=" do
    it "exercises after_remove_for_purchases= somehow" do
      subject.after_remove_for_purchases= 1
    end
  end
  context "after_remove_for_purchases?" do
    it "exercises after_remove_for_purchases? somehow" do
      subject.after_remove_for_purchases? 
    end
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_parentable" do
    it "exercises autosave_associated_records_for_parentable somehow" do
      subject.autosave_associated_records_for_parentable 
    end
  end
  context "autosave_associated_records_for_purchases" do
    it "exercises autosave_associated_records_for_purchases somehow" do
      subject.autosave_associated_records_for_purchases 
    end
  end
  context "before_add_for_purchases" do
    it "exercises before_add_for_purchases somehow" do
      subject.before_add_for_purchases 
    end
  end
  context "before_add_for_purchases=" do
    it "exercises before_add_for_purchases= somehow" do
      subject.before_add_for_purchases= 1
    end
  end
  context "before_add_for_purchases?" do
    it "exercises before_add_for_purchases? somehow" do
      subject.before_add_for_purchases? 
    end
  end
  context "before_remove_for_purchases" do
    it "exercises before_remove_for_purchases somehow" do
      subject.before_remove_for_purchases 
    end
  end
  context "before_remove_for_purchases=" do
    it "exercises before_remove_for_purchases= somehow" do
      subject.before_remove_for_purchases= 1
    end
  end
  context "before_remove_for_purchases?" do
    it "exercises before_remove_for_purchases? somehow" do
      subject.before_remove_for_purchases? 
    end
  end
  context "update_product_details" do
    it "exercises update_product_details somehow" do
      subject.update_product_details 
    end
  end
  context "validate_associated_records_for_purchases" do
    it "exercises validate_associated_records_for_purchases somehow" do
      subject.validate_associated_records_for_purchases 
    end
  end

end
