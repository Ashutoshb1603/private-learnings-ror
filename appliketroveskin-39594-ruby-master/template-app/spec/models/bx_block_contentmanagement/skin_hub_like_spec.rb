require 'rails_helper'

describe BxBlockContentmanagement::SkinHubLike, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/skin_hub_like }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :objectable }
  # end
  context "associations" do
    it { should belong_to :account }
    it { should belong_to :objectable }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_objectable" do
    it "exercises autosave_associated_records_for_objectable somehow" do
      subject.autosave_associated_records_for_objectable 
    end
  end

end
