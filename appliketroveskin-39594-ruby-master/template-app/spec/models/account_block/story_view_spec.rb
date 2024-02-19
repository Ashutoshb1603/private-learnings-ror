require 'rails_helper'

describe AccountBlock::StoryView, :type => :model do
  # let (:subject) { build :account_block/story_view }
  # context "validation" do
  #   it { should validate_presence_of :story }
  #   it { should validate_presence_of :accountable }
  # end
  context "associations" do
    it { should belong_to :story }
    it { should belong_to :accountable }
  end
  context "autosave_associated_records_for_accountable" do
    it "exercises autosave_associated_records_for_accountable somehow" do
      subject.autosave_associated_records_for_accountable 
    end
  end
  context "autosave_associated_records_for_story" do
    it "exercises autosave_associated_records_for_story somehow" do
      subject.autosave_associated_records_for_story 
    end
  end

end
