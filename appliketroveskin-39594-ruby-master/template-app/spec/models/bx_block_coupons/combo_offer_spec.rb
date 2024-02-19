require 'rails_helper'

describe BxBlockCoupons::ComboOffer, :type => :model do
  # let (:subject) { build :bx_block_coupons/combo_offer }
  context "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :discount_percentage }
    it { should validate_presence_of :offer_start_date }
    it { should validate_presence_of :offer_end_date }
    # it "uniqueness_validator test for [:name]" do
    #   should validate_uniqueness_of :name 
    # end
  end
  context "associations" do
    it { should have_and_belong_to_many :sub_categories }
    it { should have_one :logo_attachment }
    it { should have_one :logo_blob }
  end
  context "after_add_for_bxblockcoupons_combooffers_sub_categories" do
    it "exercises after_add_for_bxblockcoupons_combooffers_sub_categories somehow" do
      subject.after_add_for_bxblockcoupons_combooffers_sub_categories 
    end
  end
  context "after_add_for_bxblockcoupons_combooffers_sub_categories=" do
    it "exercises after_add_for_bxblockcoupons_combooffers_sub_categories= somehow" do
      subject.after_add_for_bxblockcoupons_combooffers_sub_categories= 1
    end
  end
  context "after_add_for_bxblockcoupons_combooffers_sub_categories?" do
    it "exercises after_add_for_bxblockcoupons_combooffers_sub_categories? somehow" do
      subject.after_add_for_bxblockcoupons_combooffers_sub_categories? 
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
  context "after_remove_for_bxblockcoupons_combooffers_sub_categories" do
    it "exercises after_remove_for_bxblockcoupons_combooffers_sub_categories somehow" do
      subject.after_remove_for_bxblockcoupons_combooffers_sub_categories 
    end
  end
  context "after_remove_for_bxblockcoupons_combooffers_sub_categories=" do
    it "exercises after_remove_for_bxblockcoupons_combooffers_sub_categories= somehow" do
      subject.after_remove_for_bxblockcoupons_combooffers_sub_categories= 1
    end
  end
  context "after_remove_for_bxblockcoupons_combooffers_sub_categories?" do
    it "exercises after_remove_for_bxblockcoupons_combooffers_sub_categories? somehow" do
      subject.after_remove_for_bxblockcoupons_combooffers_sub_categories? 
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
  context "autosave_associated_records_for_bxblockcoupons_combooffers_sub_categories" do
    it "exercises autosave_associated_records_for_bxblockcoupons_combooffers_sub_categories somehow" do
      subject.autosave_associated_records_for_bxblockcoupons_combooffers_sub_categories 
    end
  end
  context "autosave_associated_records_for_logo_attachment" do
    it "exercises autosave_associated_records_for_logo_attachment somehow" do
      subject.autosave_associated_records_for_logo_attachment 
    end
  end
  context "autosave_associated_records_for_logo_blob" do
    it "exercises autosave_associated_records_for_logo_blob somehow" do
      subject.autosave_associated_records_for_logo_blob 
    end
  end
  context "autosave_associated_records_for_sub_categories" do
    it "exercises autosave_associated_records_for_sub_categories somehow" do
      subject.autosave_associated_records_for_sub_categories 
    end
  end
  context "before_add_for_bxblockcoupons_combooffers_sub_categories" do
    it "exercises before_add_for_bxblockcoupons_combooffers_sub_categories somehow" do
      subject.before_add_for_bxblockcoupons_combooffers_sub_categories 
    end
  end
  context "before_add_for_bxblockcoupons_combooffers_sub_categories=" do
    it "exercises before_add_for_bxblockcoupons_combooffers_sub_categories= somehow" do
      subject.before_add_for_bxblockcoupons_combooffers_sub_categories= 1
    end
  end
  context "before_add_for_bxblockcoupons_combooffers_sub_categories?" do
    it "exercises before_add_for_bxblockcoupons_combooffers_sub_categories? somehow" do
      subject.before_add_for_bxblockcoupons_combooffers_sub_categories? 
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
  context "before_remove_for_bxblockcoupons_combooffers_sub_categories" do
    it "exercises before_remove_for_bxblockcoupons_combooffers_sub_categories somehow" do
      subject.before_remove_for_bxblockcoupons_combooffers_sub_categories 
    end
  end
  context "before_remove_for_bxblockcoupons_combooffers_sub_categories=" do
    it "exercises before_remove_for_bxblockcoupons_combooffers_sub_categories= somehow" do
      subject.before_remove_for_bxblockcoupons_combooffers_sub_categories= 1
    end
  end
  context "before_remove_for_bxblockcoupons_combooffers_sub_categories?" do
    it "exercises before_remove_for_bxblockcoupons_combooffers_sub_categories? somehow" do
      subject.before_remove_for_bxblockcoupons_combooffers_sub_categories? 
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
  context "logo_attachment_id" do
    it "exercises logo_attachment_id somehow" do
      subject.logo_attachment_id 
    end
  end
  context "logo_blob_id" do
    it "exercises logo_blob_id somehow" do
      subject.logo_blob_id 
    end
  end
  context "validate_associated_records_for_bxblockcoupons_combooffers_sub_categories" do
    it "exercises validate_associated_records_for_bxblockcoupons_combooffers_sub_categories somehow" do
      subject.validate_associated_records_for_bxblockcoupons_combooffers_sub_categories 
    end
  end
  context "validate_associated_records_for_sub_categories" do
    it "exercises validate_associated_records_for_sub_categories somehow" do
      subject.validate_associated_records_for_sub_categories 
    end
  end

end
