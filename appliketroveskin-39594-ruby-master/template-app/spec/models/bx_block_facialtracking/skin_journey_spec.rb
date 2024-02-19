require 'rails_helper'

describe BxBlockFacialtracking::SkinJourney, :type => :model do
  # let (:subject) { build :bx_block_facialtracking/skin_journey }
  # context "validation" do
  #   it { should validate_presence_of :therapist }
  #   it { should validate_presence_of :account }
  # end
  context "associations" do
    it { should belong_to :therapist }
    it { should belong_to :account }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_therapist" do
    it "exercises autosave_associated_records_for_therapist somehow" do
      subject.autosave_associated_records_for_therapist 
    end
  end

end
