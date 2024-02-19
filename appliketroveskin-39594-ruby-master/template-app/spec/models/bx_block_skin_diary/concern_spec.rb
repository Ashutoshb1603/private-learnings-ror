require 'rails_helper'

describe BxBlockSkinDiary::Concern, :type => :model do
  # let (:subject) { build :bx_block_skin_diary/concern }
  context "validation" do
  end
  context "associations" do
    it { should have_many :skin_stories }
  end
  context "after_add_for_skin_stories" do
    it "exercises after_add_for_skin_stories somehow" do
      subject.after_add_for_skin_stories 
    end
  end
  context "after_add_for_skin_stories=" do
    it "exercises after_add_for_skin_stories= somehow" do
      subject.after_add_for_skin_stories= 1
    end
  end
  context "after_add_for_skin_stories?" do
    it "exercises after_add_for_skin_stories? somehow" do
      subject.after_add_for_skin_stories? 
    end
  end
  context "after_remove_for_skin_stories" do
    it "exercises after_remove_for_skin_stories somehow" do
      subject.after_remove_for_skin_stories 
    end
  end
  context "after_remove_for_skin_stories=" do
    it "exercises after_remove_for_skin_stories= somehow" do
      subject.after_remove_for_skin_stories= 1
    end
  end
  context "after_remove_for_skin_stories?" do
    it "exercises after_remove_for_skin_stories? somehow" do
      subject.after_remove_for_skin_stories? 
    end
  end
  context "autosave_associated_records_for_skin_stories" do
    it "exercises autosave_associated_records_for_skin_stories somehow" do
      subject.autosave_associated_records_for_skin_stories 
    end
  end
  context "before_add_for_skin_stories" do
    it "exercises before_add_for_skin_stories somehow" do
      subject.before_add_for_skin_stories 
    end
  end
  context "before_add_for_skin_stories=" do
    it "exercises before_add_for_skin_stories= somehow" do
      subject.before_add_for_skin_stories= 1
    end
  end
  context "before_add_for_skin_stories?" do
    it "exercises before_add_for_skin_stories? somehow" do
      subject.before_add_for_skin_stories? 
    end
  end
  context "before_remove_for_skin_stories" do
    it "exercises before_remove_for_skin_stories somehow" do
      subject.before_remove_for_skin_stories 
    end
  end
  context "before_remove_for_skin_stories=" do
    it "exercises before_remove_for_skin_stories= somehow" do
      subject.before_remove_for_skin_stories= 1
    end
  end
  context "before_remove_for_skin_stories?" do
    it "exercises before_remove_for_skin_stories? somehow" do
      subject.before_remove_for_skin_stories? 
    end
  end
  context "validate_associated_records_for_skin_stories" do
    it "exercises validate_associated_records_for_skin_stories somehow" do
      subject.validate_associated_records_for_skin_stories 
    end
  end

end
