require 'rails_helper'

describe BxBlockCommunityforum::View, :type => :model do
  # let (:subject) { build :bx_block_communityforum/view }
  # context "validation" do
  #   it { should validate_presence_of :question }
  #   it { should validate_presence_of :accountable }
  # end
  context "associations" do
    it { should belong_to :question }
    it { should belong_to :accountable }
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
