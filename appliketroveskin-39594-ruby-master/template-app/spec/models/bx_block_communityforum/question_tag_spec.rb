require 'rails_helper'

describe BxBlockCommunityforum::QuestionTag, :type => :model do
  # let (:subject) { build :bx_block_communityforum/question_tag }
  # context "validation" do
  #   it { should validate_presence_of :group }
  #   it { should validate_presence_of :question }
  # end
  context "associations" do
    it { should belong_to :group }
    it { should belong_to :question }
  end
  context "autosave_associated_records_for_group" do
    it "exercises autosave_associated_records_for_group somehow" do
      subject.autosave_associated_records_for_group 
    end
  end
  context "autosave_associated_records_for_question" do
    it "exercises autosave_associated_records_for_question somehow" do
      subject.autosave_associated_records_for_question 
    end
  end

end
