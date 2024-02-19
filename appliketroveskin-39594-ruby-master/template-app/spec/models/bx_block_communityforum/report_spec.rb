require 'rails_helper'

describe BxBlockCommunityforum::Report, :type => :model do
  # let (:subject) { build :bx_block_communityforum/report }
  # context "validation" do
  #   it { should validate_presence_of :reportable }
  #   it { should validate_presence_of :accountable }
  # end
  context "associations" do
    it { should belong_to :reportable }
    it { should belong_to :accountable }
  end
  context "autosave_associated_records_for_accountable" do
    it "exercises autosave_associated_records_for_accountable somehow" do
      subject.autosave_associated_records_for_accountable 
    end
  end
  context "autosave_associated_records_for_reportable" do
    it "exercises autosave_associated_records_for_reportable somehow" do
      subject.autosave_associated_records_for_reportable 
    end
  end

end
