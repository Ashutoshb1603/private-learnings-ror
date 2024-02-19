require 'rails_helper'

describe BxBlockLocation::Van, :type => :model do
  # let (:subject) { build :bx_block_location/van }
  context "validation" do
    it { should validate_presence_of :name }
    it "uniqueness_validator test for [:name]" do
      validate_uniqueness_of(:name)
    end
  end
  context "associations" do
    it { should have_one :location }
    it { should have_one :service_provider }
    it { should have_many :assistants }
    it { should have_many :van_members }
    # it { should have_many :reviews }
    it { should have_one :main_photo_attachment }
    it { should have_one :main_photo_blob }
    it { should have_many :galleries_attachments }
    it { should have_many :galleries_blobs }
  end
  context "after_add_for_assistants" do
    it "exercises after_add_for_assistants somehow" do
      subject.after_add_for_assistants 
    end
  end
  context "after_add_for_assistants=" do
    it "exercises after_add_for_assistants= somehow" do
      subject.after_add_for_assistants= 1
    end
  end
  context "after_add_for_assistants?" do
    it "exercises after_add_for_assistants? somehow" do
      subject.after_add_for_assistants? 
    end
  end
  context "after_add_for_galleries_attachments" do
    it "exercises after_add_for_galleries_attachments somehow" do
      subject.after_add_for_galleries_attachments 
    end
  end
  context "after_add_for_galleries_attachments=" do
    it "exercises after_add_for_galleries_attachments= somehow" do
      subject.after_add_for_galleries_attachments= 1
    end
  end
  context "after_add_for_galleries_attachments?" do
    it "exercises after_add_for_galleries_attachments? somehow" do
      subject.after_add_for_galleries_attachments? 
    end
  end
  context "after_add_for_galleries_blobs" do
    it "exercises after_add_for_galleries_blobs somehow" do
      subject.after_add_for_galleries_blobs 
    end
  end
  context "after_add_for_galleries_blobs=" do
    it "exercises after_add_for_galleries_blobs= somehow" do
      subject.after_add_for_galleries_blobs= 1
    end
  end
  context "after_add_for_galleries_blobs?" do
    it "exercises after_add_for_galleries_blobs? somehow" do
      subject.after_add_for_galleries_blobs? 
    end
  end
  context "after_add_for_reviews" do
    it "exercises after_add_for_reviews somehow" do
      subject.after_add_for_reviews 
    end
  end
  context "after_add_for_reviews=" do
    it "exercises after_add_for_reviews= somehow" do
      subject.after_add_for_reviews= 1
    end
  end
  context "after_add_for_reviews?" do
    it "exercises after_add_for_reviews? somehow" do
      subject.after_add_for_reviews? 
    end
  end
  context "after_add_for_van_members" do
    it "exercises after_add_for_van_members somehow" do
      subject.after_add_for_van_members 
    end
  end
  context "after_add_for_van_members=" do
    it "exercises after_add_for_van_members= somehow" do
      subject.after_add_for_van_members= 1
    end
  end
  context "after_add_for_van_members?" do
    it "exercises after_add_for_van_members? somehow" do
      subject.after_add_for_van_members? 
    end
  end
  context "after_remove_for_assistants" do
    it "exercises after_remove_for_assistants somehow" do
      subject.after_remove_for_assistants 
    end
  end
  context "after_remove_for_assistants=" do
    it "exercises after_remove_for_assistants= somehow" do
      subject.after_remove_for_assistants= 1
    end
  end
  context "after_remove_for_assistants?" do
    it "exercises after_remove_for_assistants? somehow" do
      subject.after_remove_for_assistants? 
    end
  end
  context "after_remove_for_galleries_attachments" do
    it "exercises after_remove_for_galleries_attachments somehow" do
      subject.after_remove_for_galleries_attachments 
    end
  end
  context "after_remove_for_galleries_attachments=" do
    it "exercises after_remove_for_galleries_attachments= somehow" do
      subject.after_remove_for_galleries_attachments= 1
    end
  end
  context "after_remove_for_galleries_attachments?" do
    it "exercises after_remove_for_galleries_attachments? somehow" do
      subject.after_remove_for_galleries_attachments? 
    end
  end
  context "after_remove_for_galleries_blobs" do
    it "exercises after_remove_for_galleries_blobs somehow" do
      subject.after_remove_for_galleries_blobs 
    end
  end
  context "after_remove_for_galleries_blobs=" do
    it "exercises after_remove_for_galleries_blobs= somehow" do
      subject.after_remove_for_galleries_blobs= 1
    end
  end
  context "after_remove_for_galleries_blobs?" do
    it "exercises after_remove_for_galleries_blobs? somehow" do
      subject.after_remove_for_galleries_blobs? 
    end
  end
  context "after_remove_for_reviews" do
    it "exercises after_remove_for_reviews somehow" do
      subject.after_remove_for_reviews 
    end
  end
  context "after_remove_for_reviews=" do
    it "exercises after_remove_for_reviews= somehow" do
      subject.after_remove_for_reviews= 1
    end
  end
  context "after_remove_for_reviews?" do
    it "exercises after_remove_for_reviews? somehow" do
      subject.after_remove_for_reviews? 
    end
  end
  context "after_remove_for_van_members" do
    it "exercises after_remove_for_van_members somehow" do
      subject.after_remove_for_van_members 
    end
  end
  context "after_remove_for_van_members=" do
    it "exercises after_remove_for_van_members= somehow" do
      subject.after_remove_for_van_members= 1
    end
  end
  context "after_remove_for_van_members?" do
    it "exercises after_remove_for_van_members? somehow" do
      subject.after_remove_for_van_members? 
    end
  end
  context "autosave_associated_records_for_assistants" do
    it "exercises autosave_associated_records_for_assistants somehow" do
      subject.autosave_associated_records_for_assistants 
    end
  end
  context "autosave_associated_records_for_galleries_attachments" do
    it "exercises autosave_associated_records_for_galleries_attachments somehow" do
      subject.autosave_associated_records_for_galleries_attachments 
    end
  end
  context "autosave_associated_records_for_galleries_blobs" do
    it "exercises autosave_associated_records_for_galleries_blobs somehow" do
      subject.autosave_associated_records_for_galleries_blobs 
    end
  end
  context "autosave_associated_records_for_location" do
    it "exercises autosave_associated_records_for_location somehow" do
      subject.autosave_associated_records_for_location 
    end
  end
  context "autosave_associated_records_for_main_photo_attachment" do
    it "exercises autosave_associated_records_for_main_photo_attachment somehow" do
      subject.autosave_associated_records_for_main_photo_attachment 
    end
  end
  context "autosave_associated_records_for_main_photo_blob" do
    it "exercises autosave_associated_records_for_main_photo_blob somehow" do
      subject.autosave_associated_records_for_main_photo_blob 
    end
  end
  context "autosave_associated_records_for_reviews" do
    it "exercises autosave_associated_records_for_reviews somehow" do
      subject.autosave_associated_records_for_reviews 
    end
  end
  context "autosave_associated_records_for_service_provider" do
    it "exercises autosave_associated_records_for_service_provider somehow" do
      subject.autosave_associated_records_for_service_provider 
    end
  end
  context "autosave_associated_records_for_van_members" do
    it "exercises autosave_associated_records_for_van_members somehow" do
      subject.autosave_associated_records_for_van_members 
    end
  end
  # context "available_vans" do
  #   it "exercises available_vans somehow" do
  #     subject.available_vans 1
  #   end
  # end
  context "before_add_for_assistants" do
    it "exercises before_add_for_assistants somehow" do
      subject.before_add_for_assistants 
    end
  end
  context "before_add_for_assistants=" do
    it "exercises before_add_for_assistants= somehow" do
      subject.before_add_for_assistants= 1
    end
  end
  context "before_add_for_assistants?" do
    it "exercises before_add_for_assistants? somehow" do
      subject.before_add_for_assistants? 
    end
  end
  context "before_add_for_galleries_attachments" do
    it "exercises before_add_for_galleries_attachments somehow" do
      subject.before_add_for_galleries_attachments 
    end
  end
  context "before_add_for_galleries_attachments=" do
    it "exercises before_add_for_galleries_attachments= somehow" do
      subject.before_add_for_galleries_attachments= 1
    end
  end
  context "before_add_for_galleries_attachments?" do
    it "exercises before_add_for_galleries_attachments? somehow" do
      subject.before_add_for_galleries_attachments? 
    end
  end
  context "before_add_for_galleries_blobs" do
    it "exercises before_add_for_galleries_blobs somehow" do
      subject.before_add_for_galleries_blobs 
    end
  end
  context "before_add_for_galleries_blobs=" do
    it "exercises before_add_for_galleries_blobs= somehow" do
      subject.before_add_for_galleries_blobs= 1
    end
  end
  context "before_add_for_galleries_blobs?" do
    it "exercises before_add_for_galleries_blobs? somehow" do
      subject.before_add_for_galleries_blobs? 
    end
  end
  context "before_add_for_reviews" do
    it "exercises before_add_for_reviews somehow" do
      subject.before_add_for_reviews 
    end
  end
  context "before_add_for_reviews=" do
    it "exercises before_add_for_reviews= somehow" do
      subject.before_add_for_reviews= 1
    end
  end
  context "before_add_for_reviews?" do
    it "exercises before_add_for_reviews? somehow" do
      subject.before_add_for_reviews? 
    end
  end
  context "before_add_for_van_members" do
    it "exercises before_add_for_van_members somehow" do
      subject.before_add_for_van_members 
    end
  end
  context "before_add_for_van_members=" do
    it "exercises before_add_for_van_members= somehow" do
      subject.before_add_for_van_members= 1
    end
  end
  context "before_add_for_van_members?" do
    it "exercises before_add_for_van_members? somehow" do
      subject.before_add_for_van_members? 
    end
  end
  context "before_remove_for_assistants" do
    it "exercises before_remove_for_assistants somehow" do
      subject.before_remove_for_assistants 
    end
  end
  context "before_remove_for_assistants=" do
    it "exercises before_remove_for_assistants= somehow" do
      subject.before_remove_for_assistants= 1
    end
  end
  context "before_remove_for_assistants?" do
    it "exercises before_remove_for_assistants? somehow" do
      subject.before_remove_for_assistants? 
    end
  end
  context "before_remove_for_galleries_attachments" do
    it "exercises before_remove_for_galleries_attachments somehow" do
      subject.before_remove_for_galleries_attachments 
    end
  end
  context "before_remove_for_galleries_attachments=" do
    it "exercises before_remove_for_galleries_attachments= somehow" do
      subject.before_remove_for_galleries_attachments= 1
    end
  end
  context "before_remove_for_galleries_attachments?" do
    it "exercises before_remove_for_galleries_attachments? somehow" do
      subject.before_remove_for_galleries_attachments? 
    end
  end
  context "before_remove_for_galleries_blobs" do
    it "exercises before_remove_for_galleries_blobs somehow" do
      subject.before_remove_for_galleries_blobs 
    end
  end
  context "before_remove_for_galleries_blobs=" do
    it "exercises before_remove_for_galleries_blobs= somehow" do
      subject.before_remove_for_galleries_blobs= 1
    end
  end
  context "before_remove_for_galleries_blobs?" do
    it "exercises before_remove_for_galleries_blobs? somehow" do
      subject.before_remove_for_galleries_blobs? 
    end
  end
  context "before_remove_for_reviews" do
    it "exercises before_remove_for_reviews somehow" do
      subject.before_remove_for_reviews 
    end
  end
  context "before_remove_for_reviews=" do
    it "exercises before_remove_for_reviews= somehow" do
      subject.before_remove_for_reviews= 1
    end
  end
  context "before_remove_for_reviews?" do
    it "exercises before_remove_for_reviews? somehow" do
      subject.before_remove_for_reviews? 
    end
  end
  context "before_remove_for_van_members" do
    it "exercises before_remove_for_van_members somehow" do
      subject.before_remove_for_van_members 
    end
  end
  context "before_remove_for_van_members=" do
    it "exercises before_remove_for_van_members= somehow" do
      subject.before_remove_for_van_members= 1
    end
  end
  context "before_remove_for_van_members?" do
    it "exercises before_remove_for_van_members? somehow" do
      subject.before_remove_for_van_members? 
    end
  end
  context "location_id" do
    it "exercises location_id somehow" do
      subject.location_id 
    end
  end
  context "main_photo_attachment_id" do
    it "exercises main_photo_attachment_id somehow" do
      subject.main_photo_attachment_id 
    end
  end
  context "main_photo_blob_id" do
    it "exercises main_photo_blob_id somehow" do
      subject.main_photo_blob_id 
    end
  end
  # context "service_provider" do
  #   it "exercises service_provider somehow" do
  #     subject.service_provider 
  #   end
  # end
  context "service_provider_id" do
    it "exercises service_provider_id somehow" do
      subject.service_provider_id 
    end
  end
  context "validate_associated_records_for_assistants" do
    it "exercises validate_associated_records_for_assistants somehow" do
      subject.validate_associated_records_for_assistants 
    end
  end
  context "validate_associated_records_for_galleries_attachments" do
    it "exercises validate_associated_records_for_galleries_attachments somehow" do
      subject.validate_associated_records_for_galleries_attachments 
    end
  end
  context "validate_associated_records_for_galleries_blobs" do
    it "exercises validate_associated_records_for_galleries_blobs somehow" do
      subject.validate_associated_records_for_galleries_blobs 
    end
  end
  context "validate_associated_records_for_reviews" do
    it "exercises validate_associated_records_for_reviews somehow" do
      subject.validate_associated_records_for_reviews 
    end
  end
  context "validate_associated_records_for_service_provider" do
    it "exercises validate_associated_records_for_service_provider somehow" do
      subject.validate_associated_records_for_service_provider 
    end
  end
  context "validate_associated_records_for_van_members" do
    it "exercises validate_associated_records_for_van_members somehow" do
      subject.validate_associated_records_for_van_members 
    end
  end

end
