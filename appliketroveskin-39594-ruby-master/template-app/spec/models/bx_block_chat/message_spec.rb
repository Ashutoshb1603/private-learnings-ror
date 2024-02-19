require 'rails_helper'

describe BxBlockChat::Message, :type => :model do
  # let (:subject) { build :bx_block_chat/message }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :chat }
  # end
  context "associations" do
    # it { should belong_to :objectable }
    it { should belong_to :account }
    it { should belong_to :chat }
    it { should have_many :message_objects }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
  end
  context "after_add_for_message_objects" do
    it "exercises after_add_for_message_objects somehow" do
      subject.after_add_for_message_objects 
    end
  end
  context "after_add_for_message_objects=" do
    it "exercises after_add_for_message_objects= somehow" do
      subject.after_add_for_message_objects= 1
    end
  end
  context "after_add_for_message_objects?" do
    it "exercises after_add_for_message_objects? somehow" do
      subject.after_add_for_message_objects? 
    end
  end
  context "after_remove_for_message_objects" do
    it "exercises after_remove_for_message_objects somehow" do
      subject.after_remove_for_message_objects 
    end
  end
  context "after_remove_for_message_objects=" do
    it "exercises after_remove_for_message_objects= somehow" do
      subject.after_remove_for_message_objects= 1
    end
  end
  context "after_remove_for_message_objects?" do
    it "exercises after_remove_for_message_objects? somehow" do
      subject.after_remove_for_message_objects? 
    end
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_chat" do
    it "exercises autosave_associated_records_for_chat somehow" do
      subject.autosave_associated_records_for_chat 
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
  context "autosave_associated_records_for_message_objects" do
    it "exercises autosave_associated_records_for_message_objects somehow" do
      subject.autosave_associated_records_for_message_objects 
    end
  end
  context "autosave_associated_records_for_objectable" do
    it "exercises autosave_associated_records_for_objectable somehow" do
      subject.autosave_associated_records_for_objectable 
    end
  end
  context "before_add_for_message_objects" do
    it "exercises before_add_for_message_objects somehow" do
      subject.before_add_for_message_objects 
    end
  end
  context "before_add_for_message_objects=" do
    it "exercises before_add_for_message_objects= somehow" do
      subject.before_add_for_message_objects= 1
    end
  end
  context "before_add_for_message_objects?" do
    it "exercises before_add_for_message_objects? somehow" do
      subject.before_add_for_message_objects? 
    end
  end
  context "before_remove_for_message_objects" do
    it "exercises before_remove_for_message_objects somehow" do
      subject.before_remove_for_message_objects 
    end
  end
  context "before_remove_for_message_objects=" do
    it "exercises before_remove_for_message_objects= somehow" do
      subject.before_remove_for_message_objects= 1
    end
  end
  context "before_remove_for_message_objects?" do
    it "exercises before_remove_for_message_objects? somehow" do
      subject.before_remove_for_message_objects? 
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
  context "validate_associated_records_for_message_objects" do
    it "exercises validate_associated_records_for_message_objects somehow" do
      subject.validate_associated_records_for_message_objects 
    end
  end

end
