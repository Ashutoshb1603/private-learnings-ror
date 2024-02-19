require 'rails_helper'

describe BxBlockEvent::FrameImage, :type => :model do
  # let (:subject) { build :bx_block_event/frame_image }
  # context "validation" do
  #   it { should validate_presence_of :life_event }
  #   it { should validate_presence_of :user_type }
  #   it { should validate_presence_of :image }
  # end
  context "associations" do
    it { should belong_to :life_event }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
  end
  context "autosave_associated_records_for_image_attachment" do
    it "exercises autosave_associated_records_for_image_attachment somehow" do
      subject.autosave_associated_records_for_image_attachment 
    end
  end
  context "autosave_associated_records_for_image_blob" do
    it "exercises autosave_associated_records_for_image_blob somehow" do
      subject.autosave_associated_records_for_image_blob 
    end
  end
  context "autosave_associated_records_for_life_event" do
    it "exercises autosave_associated_records_for_life_event somehow" do
      subject.autosave_associated_records_for_life_event 
    end
  end
  context "image_attachment_id" do
    it "exercises image_attachment_id somehow" do
      subject.image_attachment_id 
    end
  end
  context "image_blob_id" do
    it "exercises image_blob_id somehow" do
      subject.image_blob_id 
    end
  end
  context "validate_image_content_type" do
    it "exercises validate_image_content_type somehow" do
      subject.validate_image_content_type 
    end
  end

end
