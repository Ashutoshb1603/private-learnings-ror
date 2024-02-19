require 'rails_helper'

describe BxBlockSkinDiary::SkinStory, :type => :model do
  # let (:subject) { build :bx_block_skin_diary/skin_story }
  # context "validation" do
  #   it { should validate_presence_of :concern }
  # end
  context "associations" do
    it { should belong_to :concern }
    it { should have_one :before_image_attachment }
    it { should have_one :before_image_blob }
    it { should have_one :after_image_attachment }
    it { should have_one :after_image_blob }
  end
  context "after_image_attachment_id" do
    it "exercises after_image_attachment_id somehow" do
      subject.after_image_attachment_id 
    end
  end
  context "after_image_blob_id" do
    it "exercises after_image_blob_id somehow" do
      subject.after_image_blob_id 
    end
  end
  context "autosave_associated_records_for_after_image_attachment" do
    it "exercises autosave_associated_records_for_after_image_attachment somehow" do
      subject.autosave_associated_records_for_after_image_attachment 
    end
  end
  context "autosave_associated_records_for_after_image_blob" do
    it "exercises autosave_associated_records_for_after_image_blob somehow" do
      subject.autosave_associated_records_for_after_image_blob 
    end
  end
  context "autosave_associated_records_for_before_image_attachment" do
    it "exercises autosave_associated_records_for_before_image_attachment somehow" do
      subject.autosave_associated_records_for_before_image_attachment 
    end
  end
  context "autosave_associated_records_for_before_image_blob" do
    it "exercises autosave_associated_records_for_before_image_blob somehow" do
      subject.autosave_associated_records_for_before_image_blob 
    end
  end
  context "autosave_associated_records_for_concern" do
    it "exercises autosave_associated_records_for_concern somehow" do
      subject.autosave_associated_records_for_concern 
    end
  end
  context "before_image_attachment_id" do
    it "exercises before_image_attachment_id somehow" do
      subject.before_image_attachment_id 
    end
  end
  context "before_image_blob_id" do
    it "exercises before_image_blob_id somehow" do
      subject.before_image_blob_id 
    end
  end

end
