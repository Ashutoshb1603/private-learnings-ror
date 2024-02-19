require 'rails_helper'

describe BxBlockCategories::Category, :type => :model do
  # let (:subject) { build :bx_block_categories/category }
  context "validation" do
    it "uniqueness_validator test for [:name]" do
      validate_uniqueness_of(:name)
    end
  end
  context "associations" do
    it { should have_and_belong_to_many :sub_categories }
  end
  context "after_add_for_bxblockcategories_categories_sub_categories" do
    it "exercises after_add_for_bxblockcategories_categories_sub_categories somehow" do
      subject.after_add_for_bxblockcategories_categories_sub_categories 
    end
  end
  context "after_add_for_bxblockcategories_categories_sub_categories=" do
    it "exercises after_add_for_bxblockcategories_categories_sub_categories= somehow" do
      subject.after_add_for_bxblockcategories_categories_sub_categories= 1
    end
  end
  context "after_add_for_bxblockcategories_categories_sub_categories?" do
    it "exercises after_add_for_bxblockcategories_categories_sub_categories? somehow" do
      subject.after_add_for_bxblockcategories_categories_sub_categories? 
    end
  end
  context "after_add_for_sub_categories" do
    it "exercises after_add_for_sub_categories somehow" do
      subject.after_add_for_sub_categories 
    end
  end
  context "after_add_for_sub_categories=" do
    it "exercises after_add_for_sub_categories= somehow" do
      subject.after_add_for_sub_categories= 1
    end
  end
  context "after_add_for_sub_categories?" do
    it "exercises after_add_for_sub_categories? somehow" do
      subject.after_add_for_sub_categories? 
    end
  end
  context "after_remove_for_bxblockcategories_categories_sub_categories" do
    it "exercises after_remove_for_bxblockcategories_categories_sub_categories somehow" do
      subject.after_remove_for_bxblockcategories_categories_sub_categories 
    end
  end
  context "after_remove_for_bxblockcategories_categories_sub_categories=" do
    it "exercises after_remove_for_bxblockcategories_categories_sub_categories= somehow" do
      subject.after_remove_for_bxblockcategories_categories_sub_categories= 1
    end
  end
  context "after_remove_for_bxblockcategories_categories_sub_categories?" do
    it "exercises after_remove_for_bxblockcategories_categories_sub_categories? somehow" do
      subject.after_remove_for_bxblockcategories_categories_sub_categories? 
    end
  end
  context "after_remove_for_sub_categories" do
    it "exercises after_remove_for_sub_categories somehow" do
      subject.after_remove_for_sub_categories 
    end
  end
  context "after_remove_for_sub_categories=" do
    it "exercises after_remove_for_sub_categories= somehow" do
      subject.after_remove_for_sub_categories= 1
    end
  end
  context "after_remove_for_sub_categories?" do
    it "exercises after_remove_for_sub_categories? somehow" do
      subject.after_remove_for_sub_categories? 
    end
  end
  context "autosave_associated_records_for_bxblockcategories_categories_sub_categories" do
    it "exercises autosave_associated_records_for_bxblockcategories_categories_sub_categories somehow" do
      subject.autosave_associated_records_for_bxblockcategories_categories_sub_categories 
    end
  end
  context "autosave_associated_records_for_sub_categories" do
    it "exercises autosave_associated_records_for_sub_categories somehow" do
      subject.autosave_associated_records_for_sub_categories 
    end
  end
  context "before_add_for_bxblockcategories_categories_sub_categories" do
    it "exercises before_add_for_bxblockcategories_categories_sub_categories somehow" do
      subject.before_add_for_bxblockcategories_categories_sub_categories 
    end
  end
  context "before_add_for_bxblockcategories_categories_sub_categories=" do
    it "exercises before_add_for_bxblockcategories_categories_sub_categories= somehow" do
      subject.before_add_for_bxblockcategories_categories_sub_categories= 1
    end
  end
  context "before_add_for_bxblockcategories_categories_sub_categories?" do
    it "exercises before_add_for_bxblockcategories_categories_sub_categories? somehow" do
      subject.before_add_for_bxblockcategories_categories_sub_categories? 
    end
  end
  context "before_add_for_sub_categories" do
    it "exercises before_add_for_sub_categories somehow" do
      subject.before_add_for_sub_categories 
    end
  end
  context "before_add_for_sub_categories=" do
    it "exercises before_add_for_sub_categories= somehow" do
      subject.before_add_for_sub_categories= 1
    end
  end
  context "before_add_for_sub_categories?" do
    it "exercises before_add_for_sub_categories? somehow" do
      subject.before_add_for_sub_categories? 
    end
  end
  context "before_remove_for_bxblockcategories_categories_sub_categories" do
    it "exercises before_remove_for_bxblockcategories_categories_sub_categories somehow" do
      subject.before_remove_for_bxblockcategories_categories_sub_categories 
    end
  end
  context "before_remove_for_bxblockcategories_categories_sub_categories=" do
    it "exercises before_remove_for_bxblockcategories_categories_sub_categories= somehow" do
      subject.before_remove_for_bxblockcategories_categories_sub_categories= 1
    end
  end
  context "before_remove_for_bxblockcategories_categories_sub_categories?" do
    it "exercises before_remove_for_bxblockcategories_categories_sub_categories? somehow" do
      subject.before_remove_for_bxblockcategories_categories_sub_categories? 
    end
  end
  context "before_remove_for_sub_categories" do
    it "exercises before_remove_for_sub_categories somehow" do
      subject.before_remove_for_sub_categories 
    end
  end
  context "before_remove_for_sub_categories=" do
    it "exercises before_remove_for_sub_categories= somehow" do
      subject.before_remove_for_sub_categories= 1
    end
  end
  context "before_remove_for_sub_categories?" do
    it "exercises before_remove_for_sub_categories? somehow" do
      subject.before_remove_for_sub_categories? 
    end
  end
  context "validate_associated_records_for_bxblockcategories_categories_sub_categories" do
    it "exercises validate_associated_records_for_bxblockcategories_categories_sub_categories somehow" do
      subject.validate_associated_records_for_bxblockcategories_categories_sub_categories 
    end
  end
  context "validate_associated_records_for_sub_categories" do
    it "exercises validate_associated_records_for_sub_categories somehow" do
      subject.validate_associated_records_for_sub_categories 
    end
  end

end
