require 'rails_helper'

describe BxBlockCommunityforum::Saved, :type => :model do
  # let (:subject) { build :bx_block_communityforum/saved }
  # context "validation" do
  #   it { should validate_presence_of :accountable }
  #   it { should validate_presence_of :question }
  # end
  context "associations" do
    it { should belong_to :accountable }
    it { should belong_to :question }
  end
  context "autosave_associated_records_for_accountable" do
    it "exercises autosave_associated_records_for_accountable somehow" do
      subject.autosave_associated_records_for_accountable 
    end
  end
  context "autosave_associated_records_for_question" do
    it "exercises autosave_associated_records_for_question somehow" do
      subject.autosave_associated_records_for_question 
    end
  end

end
