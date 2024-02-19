require 'rails_helper'

describe BxBlockFacialtracking::UserImage, :type => :model do
  # let (:subject) { build :bx_block_facialtracking/user_image }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :image }
  #   it { should validate_presence_of :position }
  # end
  context "associations" do
    it { should belong_to :account }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
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
