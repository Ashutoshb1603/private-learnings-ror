require 'rails_helper'

describe BxBlockChat::MessageObject, :type => :model do
  # let (:subject) { build :bx_block_chat/message_object }
  # context "validation" do
  #   it { should validate_presence_of :message }
  # end
  context "associations" do
    it { should belong_to :message }
  end
  context "autosave_associated_records_for_message" do
    it "exercises autosave_associated_records_for_message somehow" do
      subject.autosave_associated_records_for_message 
    end
  end

end
