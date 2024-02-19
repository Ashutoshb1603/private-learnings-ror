require 'rails_helper'

describe BxBlockLocation::VanMember, :type => :model do
  # let (:subject) { build :bx_block_location/van_member }
  # context "validation" do
  #   it { should validate_presence_of :van }
  #   it { should validate_presence_of :account }
  # end
  context "associations" do
    it { should belong_to :van }
    it { should belong_to :account }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_van" do
    it "exercises autosave_associated_records_for_van somehow" do
      subject.autosave_associated_records_for_van 
    end
  end

end
