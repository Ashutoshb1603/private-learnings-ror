require 'rails_helper'

describe BxBlockChat::Chat, :type => :model do
  # let (:subject) { build :bx_block_chat/chat }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :therapist }
  # end
  context "associations" do
    it { should belong_to :account }
    it { should belong_to :therapist }
    it { should have_many :messages }
  end
  context "add_start_and_end_time" do
    it "exercises add_start_and_end_time somehow" do
      subject.add_start_and_end_time 
    end
  end
  context "after_add_for_messages" do
    it "exercises after_add_for_messages somehow" do
      subject.after_add_for_messages 
    end
  end
  context "after_add_for_messages=" do
    it "exercises after_add_for_messages= somehow" do
      subject.after_add_for_messages= 1
    end
  end
  context "after_add_for_messages?" do
    it "exercises after_add_for_messages? somehow" do
      subject.after_add_for_messages? 
    end
  end
  context "after_remove_for_messages" do
    it "exercises after_remove_for_messages somehow" do
      subject.after_remove_for_messages 
    end
  end
  context "after_remove_for_messages=" do
    it "exercises after_remove_for_messages= somehow" do
      subject.after_remove_for_messages= 1
    end
  end
  context "after_remove_for_messages?" do
    it "exercises after_remove_for_messages? somehow" do
      subject.after_remove_for_messages? 
    end
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_messages" do
    it "exercises autosave_associated_records_for_messages somehow" do
      subject.autosave_associated_records_for_messages 
    end
  end
  context "autosave_associated_records_for_therapist" do
    it "exercises autosave_associated_records_for_therapist somehow" do
      subject.autosave_associated_records_for_therapist 
    end
  end
  context "before_add_for_messages" do
    it "exercises before_add_for_messages somehow" do
      subject.before_add_for_messages 
    end
  end
  context "before_add_for_messages=" do
    it "exercises before_add_for_messages= somehow" do
      subject.before_add_for_messages= 1
    end
  end
  context "before_add_for_messages?" do
    it "exercises before_add_for_messages? somehow" do
      subject.before_add_for_messages? 
    end
  end
  context "before_remove_for_messages" do
    it "exercises before_remove_for_messages somehow" do
      subject.before_remove_for_messages 
    end
  end
  context "before_remove_for_messages=" do
    it "exercises before_remove_for_messages= somehow" do
      subject.before_remove_for_messages= 1
    end
  end
  context "before_remove_for_messages?" do
    it "exercises before_remove_for_messages? somehow" do
      subject.before_remove_for_messages? 
    end
  end
  context "validate_associated_records_for_messages" do
    it "exercises validate_associated_records_for_messages somehow" do
      subject.validate_associated_records_for_messages 
    end
  end

end
