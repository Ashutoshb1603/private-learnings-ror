require 'rails_helper'

describe BxBlockSkinDiary::SkincareStep, :type => :model do
  # let (:subject) { build :bx_block_skin_diary/skincare_step }
  # context "validation" do
  #   it { should validate_presence_of :skincare_routine }
  # end
  context "associations" do
    it { should belong_to :skincare_routine }
    it { should have_many :skincare_products }
    it { should have_many :skincare_step_notes }
  end
  context "after_add_for_skincare_products" do
    it "exercises after_add_for_skincare_products somehow" do
      subject.after_add_for_skincare_products 
    end
  end
  context "after_add_for_skincare_products=" do
    it "exercises after_add_for_skincare_products= somehow" do
      subject.after_add_for_skincare_products= 1
    end
  end
  context "after_add_for_skincare_products?" do
    it "exercises after_add_for_skincare_products? somehow" do
      subject.after_add_for_skincare_products? 
    end
  end
  context "after_add_for_skincare_step_notes" do
    it "exercises after_add_for_skincare_step_notes somehow" do
      subject.after_add_for_skincare_step_notes 
    end
  end
  context "after_add_for_skincare_step_notes=" do
    it "exercises after_add_for_skincare_step_notes= somehow" do
      subject.after_add_for_skincare_step_notes= 1
    end
  end
  context "after_add_for_skincare_step_notes?" do
    it "exercises after_add_for_skincare_step_notes? somehow" do
      subject.after_add_for_skincare_step_notes? 
    end
  end
  context "after_remove_for_skincare_products" do
    it "exercises after_remove_for_skincare_products somehow" do
      subject.after_remove_for_skincare_products 
    end
  end
  context "after_remove_for_skincare_products=" do
    it "exercises after_remove_for_skincare_products= somehow" do
      subject.after_remove_for_skincare_products= 1
    end
  end
  context "after_remove_for_skincare_products?" do
    it "exercises after_remove_for_skincare_products? somehow" do
      subject.after_remove_for_skincare_products? 
    end
  end
  context "after_remove_for_skincare_step_notes" do
    it "exercises after_remove_for_skincare_step_notes somehow" do
      subject.after_remove_for_skincare_step_notes 
    end
  end
  context "after_remove_for_skincare_step_notes=" do
    it "exercises after_remove_for_skincare_step_notes= somehow" do
      subject.after_remove_for_skincare_step_notes= 1
    end
  end
  context "after_remove_for_skincare_step_notes?" do
    it "exercises after_remove_for_skincare_step_notes? somehow" do
      subject.after_remove_for_skincare_step_notes? 
    end
  end
  context "autosave_associated_records_for_skincare_products" do
    it "exercises autosave_associated_records_for_skincare_products somehow" do
      subject.autosave_associated_records_for_skincare_products 
    end
  end
  context "autosave_associated_records_for_skincare_routine" do
    it "exercises autosave_associated_records_for_skincare_routine somehow" do
      subject.autosave_associated_records_for_skincare_routine 
    end
  end
  context "autosave_associated_records_for_skincare_step_notes" do
    it "exercises autosave_associated_records_for_skincare_step_notes somehow" do
      subject.autosave_associated_records_for_skincare_step_notes 
    end
  end
  context "before_add_for_skincare_products" do
    it "exercises before_add_for_skincare_products somehow" do
      subject.before_add_for_skincare_products 
    end
  end
  context "before_add_for_skincare_products=" do
    it "exercises before_add_for_skincare_products= somehow" do
      subject.before_add_for_skincare_products= 1
    end
  end
  context "before_add_for_skincare_products?" do
    it "exercises before_add_for_skincare_products? somehow" do
      subject.before_add_for_skincare_products? 
    end
  end
  context "before_add_for_skincare_step_notes" do
    it "exercises before_add_for_skincare_step_notes somehow" do
      subject.before_add_for_skincare_step_notes 
    end
  end
  context "before_add_for_skincare_step_notes=" do
    it "exercises before_add_for_skincare_step_notes= somehow" do
      subject.before_add_for_skincare_step_notes= 1
    end
  end
  context "before_add_for_skincare_step_notes?" do
    it "exercises before_add_for_skincare_step_notes? somehow" do
      subject.before_add_for_skincare_step_notes? 
    end
  end
  context "before_remove_for_skincare_products" do
    it "exercises before_remove_for_skincare_products somehow" do
      subject.before_remove_for_skincare_products 
    end
  end
  context "before_remove_for_skincare_products=" do
    it "exercises before_remove_for_skincare_products= somehow" do
      subject.before_remove_for_skincare_products= 1
    end
  end
  context "before_remove_for_skincare_products?" do
    it "exercises before_remove_for_skincare_products? somehow" do
      subject.before_remove_for_skincare_products? 
    end
  end
  context "before_remove_for_skincare_step_notes" do
    it "exercises before_remove_for_skincare_step_notes somehow" do
      subject.before_remove_for_skincare_step_notes 
    end
  end
  context "before_remove_for_skincare_step_notes=" do
    it "exercises before_remove_for_skincare_step_notes= somehow" do
      subject.before_remove_for_skincare_step_notes= 1
    end
  end
  context "before_remove_for_skincare_step_notes?" do
    it "exercises before_remove_for_skincare_step_notes? somehow" do
      subject.before_remove_for_skincare_step_notes? 
    end
  end
  context "validate_associated_records_for_skincare_products" do
    it "exercises validate_associated_records_for_skincare_products somehow" do
      subject.validate_associated_records_for_skincare_products 
    end
  end
  context "validate_associated_records_for_skincare_step_notes" do
    it "exercises validate_associated_records_for_skincare_step_notes somehow" do
      subject.validate_associated_records_for_skincare_step_notes 
    end
  end

end
