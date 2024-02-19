require 'rails_helper'

describe BxBlockFacialtracking::AccountChoiceSkinQuiz, :type => :model do
  # let (:subject) { build :bx_block_facialtracking/account_choice_skin_quiz }
  # context "validation" do
  #   it { should validate_presence_of :skin_quiz }
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :choice }
  # end
  context "associations" do
    it { should belong_to :skin_quiz }
    it { should belong_to :account }
    it { should belong_to :choice }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_choice" do
    it "exercises autosave_associated_records_for_choice somehow" do
      subject.autosave_associated_records_for_choice 
    end
  end
  context "autosave_associated_records_for_skin_quiz" do
    it "exercises autosave_associated_records_for_skin_quiz somehow" do
      subject.autosave_associated_records_for_skin_quiz 
    end
  end

end
