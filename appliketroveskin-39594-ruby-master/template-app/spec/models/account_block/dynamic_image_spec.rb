require 'rails_helper'

describe AccountBlock::DynamicImage, :type => :model do
  # let (:subject) { build :account_block/dynamic_image }
  context "validation" do
    it "uniqueness_validator test for [:image_type]" do
      should define_enum_for(:image_type).with_values({'profile_pic': 1, 'admin': 2, 'brand_image': 3, 'skin_hub': 4, 'email_logo': 5,'email_cover': 6, 'visit_button': 7, 'email_tnc_icon': 8, 'policy_icon': 9, 'email_profile_icon': 10})
    end
  end
  context "associations" do
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
    it { should have_one :glow_getter_image_attachment }
    it { should have_one :glow_getter_image_blob }
  end
  context "autosave_associated_records_for_glow_getter_image_attachment" do
    it "exercises autosave_associated_records_for_glow_getter_image_attachment somehow" do
      subject.autosave_associated_records_for_glow_getter_image_attachment 
    end
  end
  context "autosave_associated_records_for_glow_getter_image_blob" do
    it "exercises autosave_associated_records_for_glow_getter_image_blob somehow" do
      subject.autosave_associated_records_for_glow_getter_image_blob 
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
  context "glow_getter_image_attachment_id" do
    it "exercises glow_getter_image_attachment_id somehow" do
      subject.glow_getter_image_attachment_id 
    end
  end
  context "glow_getter_image_blob_id" do
    it "exercises glow_getter_image_blob_id somehow" do
      subject.glow_getter_image_blob_id 
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

end
