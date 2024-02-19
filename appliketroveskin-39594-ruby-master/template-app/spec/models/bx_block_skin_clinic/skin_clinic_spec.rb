require 'rails_helper'

describe BxBlockSkinClinic::SkinClinic, :type => :model do
  # let (:subject) { build :bx_block_skin_clinic/skin_clinic }
  context "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    # it "format_validator test for [:clinic_link]"
  end
  context "associations" do
    it { should have_many :skin_clinic_availabilities }
    it { should have_many :page_clicks }
  end
  context "after_add_for_page_clicks" do
    it "exercises after_add_for_page_clicks somehow" do
      subject.after_add_for_page_clicks 
    end
  end
  context "after_add_for_page_clicks=" do
    it "exercises after_add_for_page_clicks= somehow" do
      subject.after_add_for_page_clicks= 1
    end
  end
  context "after_add_for_page_clicks?" do
    it "exercises after_add_for_page_clicks? somehow" do
      subject.after_add_for_page_clicks? 
    end
  end
  context "after_add_for_skin_clinic_availabilities" do
    it "exercises after_add_for_skin_clinic_availabilities somehow" do
      subject.after_add_for_skin_clinic_availabilities 
    end
  end
  context "after_add_for_skin_clinic_availabilities=" do
    it "exercises after_add_for_skin_clinic_availabilities= somehow" do
      subject.after_add_for_skin_clinic_availabilities= 1
    end
  end
  context "after_add_for_skin_clinic_availabilities?" do
    it "exercises after_add_for_skin_clinic_availabilities? somehow" do
      subject.after_add_for_skin_clinic_availabilities? 
    end
  end
  context "after_remove_for_page_clicks" do
    it "exercises after_remove_for_page_clicks somehow" do
      subject.after_remove_for_page_clicks 
    end
  end
  context "after_remove_for_page_clicks=" do
    it "exercises after_remove_for_page_clicks= somehow" do
      subject.after_remove_for_page_clicks= 1
    end
  end
  context "after_remove_for_page_clicks?" do
    it "exercises after_remove_for_page_clicks? somehow" do
      subject.after_remove_for_page_clicks? 
    end
  end
  context "after_remove_for_skin_clinic_availabilities" do
    it "exercises after_remove_for_skin_clinic_availabilities somehow" do
      subject.after_remove_for_skin_clinic_availabilities 
    end
  end
  context "after_remove_for_skin_clinic_availabilities=" do
    it "exercises after_remove_for_skin_clinic_availabilities= somehow" do
      subject.after_remove_for_skin_clinic_availabilities= 1
    end
  end
  context "after_remove_for_skin_clinic_availabilities?" do
    it "exercises after_remove_for_skin_clinic_availabilities? somehow" do
      subject.after_remove_for_skin_clinic_availabilities? 
    end
  end
  context "autosave_associated_records_for_page_clicks" do
    it "exercises autosave_associated_records_for_page_clicks somehow" do
      subject.autosave_associated_records_for_page_clicks 
    end
  end
  context "autosave_associated_records_for_skin_clinic_availabilities" do
    it "exercises autosave_associated_records_for_skin_clinic_availabilities somehow" do
      subject.autosave_associated_records_for_skin_clinic_availabilities 
    end
  end
  context "before_add_for_page_clicks" do
    it "exercises before_add_for_page_clicks somehow" do
      subject.before_add_for_page_clicks 
    end
  end
  context "before_add_for_page_clicks=" do
    it "exercises before_add_for_page_clicks= somehow" do
      subject.before_add_for_page_clicks= 1
    end
  end
  context "before_add_for_page_clicks?" do
    it "exercises before_add_for_page_clicks? somehow" do
      subject.before_add_for_page_clicks? 
    end
  end
  context "before_add_for_skin_clinic_availabilities" do
    it "exercises before_add_for_skin_clinic_availabilities somehow" do
      subject.before_add_for_skin_clinic_availabilities 
    end
  end
  context "before_add_for_skin_clinic_availabilities=" do
    it "exercises before_add_for_skin_clinic_availabilities= somehow" do
      subject.before_add_for_skin_clinic_availabilities= 1
    end
  end
  context "before_add_for_skin_clinic_availabilities?" do
    it "exercises before_add_for_skin_clinic_availabilities? somehow" do
      subject.before_add_for_skin_clinic_availabilities? 
    end
  end
  context "before_remove_for_page_clicks" do
    it "exercises before_remove_for_page_clicks somehow" do
      subject.before_remove_for_page_clicks 
    end
  end
  context "before_remove_for_page_clicks=" do
    it "exercises before_remove_for_page_clicks= somehow" do
      subject.before_remove_for_page_clicks= 1
    end
  end
  context "before_remove_for_page_clicks?" do
    it "exercises before_remove_for_page_clicks? somehow" do
      subject.before_remove_for_page_clicks? 
    end
  end
  context "before_remove_for_skin_clinic_availabilities" do
    it "exercises before_remove_for_skin_clinic_availabilities somehow" do
      subject.before_remove_for_skin_clinic_availabilities 
    end
  end
  context "before_remove_for_skin_clinic_availabilities=" do
    it "exercises before_remove_for_skin_clinic_availabilities= somehow" do
      subject.before_remove_for_skin_clinic_availabilities= 1
    end
  end
  context "before_remove_for_skin_clinic_availabilities?" do
    it "exercises before_remove_for_skin_clinic_availabilities? somehow" do
      subject.before_remove_for_skin_clinic_availabilities? 
    end
  end
  context "validate_associated_records_for_page_clicks" do
    it "exercises validate_associated_records_for_page_clicks somehow" do
      subject.validate_associated_records_for_page_clicks 
    end
  end
  context "validate_associated_records_for_skin_clinic_availabilities" do
    it "exercises validate_associated_records_for_skin_clinic_availabilities somehow" do
      subject.validate_associated_records_for_skin_clinic_availabilities 
    end
  end

end
