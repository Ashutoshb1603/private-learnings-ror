require 'rails_helper'

describe BxBlockPlan::Plan, :type => :model do
  # let (:subject) { build :bx_block_plan/plan }
  context "validation" do
  end
  context "associations" do
    it { should have_many :payments }
  end
  context "after_add_for_payments" do
    it "exercises after_add_for_payments somehow" do
      subject.after_add_for_payments 
    end
  end
  context "after_add_for_payments=" do
    it "exercises after_add_for_payments= somehow" do
      subject.after_add_for_payments= 1
    end
  end
  context "after_add_for_payments?" do
    it "exercises after_add_for_payments? somehow" do
      subject.after_add_for_payments? 
    end
  end
  context "after_remove_for_payments" do
    it "exercises after_remove_for_payments somehow" do
      subject.after_remove_for_payments 
    end
  end
  context "after_remove_for_payments=" do
    it "exercises after_remove_for_payments= somehow" do
      subject.after_remove_for_payments= 1
    end
  end
  context "after_remove_for_payments?" do
    it "exercises after_remove_for_payments? somehow" do
      subject.after_remove_for_payments? 
    end
  end
  context "autosave_associated_records_for_payments" do
    it "exercises autosave_associated_records_for_payments somehow" do
      subject.autosave_associated_records_for_payments 
    end
  end
  context "before_add_for_payments" do
    it "exercises before_add_for_payments somehow" do
      subject.before_add_for_payments 
    end
  end
  context "before_add_for_payments=" do
    it "exercises before_add_for_payments= somehow" do
      subject.before_add_for_payments= 1
    end
  end
  context "before_add_for_payments?" do
    it "exercises before_add_for_payments? somehow" do
      subject.before_add_for_payments? 
    end
  end
  context "before_remove_for_payments" do
    it "exercises before_remove_for_payments somehow" do
      subject.before_remove_for_payments 
    end
  end
  context "before_remove_for_payments=" do
    it "exercises before_remove_for_payments= somehow" do
      subject.before_remove_for_payments= 1
    end
  end
  context "before_remove_for_payments?" do
    it "exercises before_remove_for_payments? somehow" do
      subject.before_remove_for_payments? 
    end
  end
  context "validate_associated_records_for_payments" do
    it "exercises validate_associated_records_for_payments somehow" do
      subject.validate_associated_records_for_payments 
    end
  end

end
