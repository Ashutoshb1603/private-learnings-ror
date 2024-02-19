require 'rails_helper'

describe BxBlockSkinClinic::PageClick, :type => :model do
  # let (:subject) { build :bx_block_skin_clinic/page_click }
  # context "validation" do
  #   it { should validate_presence_of :accountable }
  #   it { should validate_presence_of :objectable }
  # end
  context "associations" do
    it { should belong_to :accountable }
    it { should belong_to :objectable }
  end
  context "autosave_associated_records_for_accountable" do
    it "exercises autosave_associated_records_for_accountable somehow" do
      subject.autosave_associated_records_for_accountable 
    end
  end
  context "autosave_associated_records_for_objectable" do
    it "exercises autosave_associated_records_for_objectable somehow" do
      subject.autosave_associated_records_for_objectable 
    end
  end

end
