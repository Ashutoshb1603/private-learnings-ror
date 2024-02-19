require 'rails_helper'

describe AccountBlock::Story, :type => :model do
  # let (:subject) { build :account_block/story }
  # context "validation" do
  #   it { should validate_presence_of :objectable }
  # end
  context "associations" do
    it { should belong_to :objectable }
    it { should have_one :video_attachment }
    it { should have_one :video_blob }
    it { should have_many :story_views }
  end
  context "after_add_for_story_views" do
    it "exercises after_add_for_story_views somehow" do
      subject.after_add_for_story_views 
    end
  end
  context "after_add_for_story_views=" do
    it "exercises after_add_for_story_views= somehow" do
      subject.after_add_for_story_views= 1
    end
  end
  context "after_add_for_story_views?" do
    it "exercises after_add_for_story_views? somehow" do
      subject.after_add_for_story_views? 
    end
  end
  context "after_remove_for_story_views" do
    it "exercises after_remove_for_story_views somehow" do
      subject.after_remove_for_story_views 
    end
  end
  context "after_remove_for_story_views=" do
    it "exercises after_remove_for_story_views= somehow" do
      subject.after_remove_for_story_views= 1
    end
  end
  context "after_remove_for_story_views?" do
    it "exercises after_remove_for_story_views? somehow" do
      subject.after_remove_for_story_views? 
    end
  end
  context "autosave_associated_records_for_objectable" do
    it "exercises autosave_associated_records_for_objectable somehow" do
      subject.autosave_associated_records_for_objectable 
    end
  end
  context "autosave_associated_records_for_story_views" do
    it "exercises autosave_associated_records_for_story_views somehow" do
      subject.autosave_associated_records_for_story_views 
    end
  end
  context "autosave_associated_records_for_video_attachment" do
    it "exercises autosave_associated_records_for_video_attachment somehow" do
      subject.autosave_associated_records_for_video_attachment 
    end
  end
  context "autosave_associated_records_for_video_blob" do
    it "exercises autosave_associated_records_for_video_blob somehow" do
      subject.autosave_associated_records_for_video_blob 
    end
  end
  context "before_add_for_story_views" do
    it "exercises before_add_for_story_views somehow" do
      subject.before_add_for_story_views 
    end
  end
  context "before_add_for_story_views=" do
    it "exercises before_add_for_story_views= somehow" do
      subject.before_add_for_story_views= 1
    end
  end
  context "before_add_for_story_views?" do
    it "exercises before_add_for_story_views? somehow" do
      subject.before_add_for_story_views? 
    end
  end
  context "before_remove_for_story_views" do
    it "exercises before_remove_for_story_views somehow" do
      subject.before_remove_for_story_views 
    end
  end
  context "before_remove_for_story_views=" do
    it "exercises before_remove_for_story_views= somehow" do
      subject.before_remove_for_story_views= 1
    end
  end
  context "before_remove_for_story_views?" do
    it "exercises before_remove_for_story_views? somehow" do
      subject.before_remove_for_story_views? 
    end
  end
  context "validate_associated_records_for_story_views" do
    it "exercises validate_associated_records_for_story_views somehow" do
      subject.validate_associated_records_for_story_views 
    end
  end
  context "video_attachment_id" do
    it "exercises video_attachment_id somehow" do
      subject.video_attachment_id 
    end
  end
  context "video_blob_id" do
    it "exercises video_blob_id somehow" do
      subject.video_blob_id 
    end
  end

end
