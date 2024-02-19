require 'rails_helper'

describe BxBlockEvent::LifeEvent, :type => :model do
  # let (:subject) { build :bx_block_event/life_event }
  context "validation" do
    it { should validate_presence_of :name }
    # it { should validate_presence_of :frame_images }
    # it "uniqueness_validator test for [:name]"
  end
  context "associations" do
    it { should have_many :user_events }
    it { should have_many :accounts }
    it { should have_many :frame_images }
  end
  context "after_add_for_accounts" do
    it "exercises after_add_for_accounts somehow" do
      subject.after_add_for_accounts 
    end
  end
  context "after_add_for_accounts=" do
    it "exercises after_add_for_accounts= somehow" do
      subject.after_add_for_accounts= 1
    end
  end
  context "after_add_for_accounts?" do
    it "exercises after_add_for_accounts? somehow" do
      subject.after_add_for_accounts? 
    end
  end
  context "after_add_for_frame_images" do
    it "exercises after_add_for_frame_images somehow" do
      subject.after_add_for_frame_images 
    end
  end
  context "after_add_for_frame_images=" do
    it "exercises after_add_for_frame_images= somehow" do
      subject.after_add_for_frame_images= 1
    end
  end
  context "after_add_for_frame_images?" do
    it "exercises after_add_for_frame_images? somehow" do
      subject.after_add_for_frame_images? 
    end
  end
  context "after_add_for_user_events" do
    it "exercises after_add_for_user_events somehow" do
      subject.after_add_for_user_events 
    end
  end
  context "after_add_for_user_events=" do
    it "exercises after_add_for_user_events= somehow" do
      subject.after_add_for_user_events= 1
    end
  end
  context "after_add_for_user_events?" do
    it "exercises after_add_for_user_events? somehow" do
      subject.after_add_for_user_events? 
    end
  end
  context "after_remove_for_accounts" do
    it "exercises after_remove_for_accounts somehow" do
      subject.after_remove_for_accounts 
    end
  end
  context "after_remove_for_accounts=" do
    it "exercises after_remove_for_accounts= somehow" do
      subject.after_remove_for_accounts= 1
    end
  end
  context "after_remove_for_accounts?" do
    it "exercises after_remove_for_accounts? somehow" do
      subject.after_remove_for_accounts? 
    end
  end
  context "after_remove_for_frame_images" do
    it "exercises after_remove_for_frame_images somehow" do
      subject.after_remove_for_frame_images 
    end
  end
  context "after_remove_for_frame_images=" do
    it "exercises after_remove_for_frame_images= somehow" do
      subject.after_remove_for_frame_images= 1
    end
  end
  context "after_remove_for_frame_images?" do
    it "exercises after_remove_for_frame_images? somehow" do
      subject.after_remove_for_frame_images? 
    end
  end
  context "after_remove_for_user_events" do
    it "exercises after_remove_for_user_events somehow" do
      subject.after_remove_for_user_events 
    end
  end
  context "after_remove_for_user_events=" do
    it "exercises after_remove_for_user_events= somehow" do
      subject.after_remove_for_user_events= 1
    end
  end
  context "after_remove_for_user_events?" do
    it "exercises after_remove_for_user_events? somehow" do
      subject.after_remove_for_user_events? 
    end
  end
  context "autosave_associated_records_for_accounts" do
    it "exercises autosave_associated_records_for_accounts somehow" do
      subject.autosave_associated_records_for_accounts 
    end
  end
  context "autosave_associated_records_for_frame_images" do
    it "exercises autosave_associated_records_for_frame_images somehow" do
      subject.autosave_associated_records_for_frame_images 
    end
  end
  context "autosave_associated_records_for_user_events" do
    it "exercises autosave_associated_records_for_user_events somehow" do
      subject.autosave_associated_records_for_user_events 
    end
  end
  context "before_add_for_accounts" do
    it "exercises before_add_for_accounts somehow" do
      subject.before_add_for_accounts 
    end
  end
  context "before_add_for_accounts=" do
    it "exercises before_add_for_accounts= somehow" do
      subject.before_add_for_accounts= 1
    end
  end
  context "before_add_for_accounts?" do
    it "exercises before_add_for_accounts? somehow" do
      subject.before_add_for_accounts? 
    end
  end
  context "before_add_for_frame_images" do
    it "exercises before_add_for_frame_images somehow" do
      subject.before_add_for_frame_images 
    end
  end
  context "before_add_for_frame_images=" do
    it "exercises before_add_for_frame_images= somehow" do
      subject.before_add_for_frame_images= 1
    end
  end
  context "before_add_for_frame_images?" do
    it "exercises before_add_for_frame_images? somehow" do
      subject.before_add_for_frame_images? 
    end
  end
  context "before_add_for_user_events" do
    it "exercises before_add_for_user_events somehow" do
      subject.before_add_for_user_events 
    end
  end
  context "before_add_for_user_events=" do
    it "exercises before_add_for_user_events= somehow" do
      subject.before_add_for_user_events= 1
    end
  end
  context "before_add_for_user_events?" do
    it "exercises before_add_for_user_events? somehow" do
      subject.before_add_for_user_events? 
    end
  end
  context "before_remove_for_accounts" do
    it "exercises before_remove_for_accounts somehow" do
      subject.before_remove_for_accounts 
    end
  end
  context "before_remove_for_accounts=" do
    it "exercises before_remove_for_accounts= somehow" do
      subject.before_remove_for_accounts= 1
    end
  end
  context "before_remove_for_accounts?" do
    it "exercises before_remove_for_accounts? somehow" do
      subject.before_remove_for_accounts? 
    end
  end
  context "before_remove_for_frame_images" do
    it "exercises before_remove_for_frame_images somehow" do
      subject.before_remove_for_frame_images 
    end
  end
  context "before_remove_for_frame_images=" do
    it "exercises before_remove_for_frame_images= somehow" do
      subject.before_remove_for_frame_images= 1
    end
  end
  context "before_remove_for_frame_images?" do
    it "exercises before_remove_for_frame_images? somehow" do
      subject.before_remove_for_frame_images? 
    end
  end
  context "before_remove_for_user_events" do
    it "exercises before_remove_for_user_events somehow" do
      subject.before_remove_for_user_events 
    end
  end
  context "before_remove_for_user_events=" do
    it "exercises before_remove_for_user_events= somehow" do
      subject.before_remove_for_user_events= 1
    end
  end
  context "before_remove_for_user_events?" do
    it "exercises before_remove_for_user_events? somehow" do
      subject.before_remove_for_user_events? 
    end
  end
  context "validate_associated_records_for_accounts" do
    it "exercises validate_associated_records_for_accounts somehow" do
      subject.validate_associated_records_for_accounts 
    end
  end
  context "validate_associated_records_for_frame_images" do
    it "exercises validate_associated_records_for_frame_images somehow" do
      subject.validate_associated_records_for_frame_images 
    end
  end
  context "validate_associated_records_for_user_events" do
    it "exercises validate_associated_records_for_user_events somehow" do
      subject.validate_associated_records_for_user_events 
    end
  end

end
