require 'rails_helper'

describe BxBlockLocation::Location, :type => :model do
  # let (:subject) { build :bx_block_location/location }
  # context "validation" do
  #   it { should validate_presence_of :van }
  # end
  context "associations" do
    it { should belong_to :van }
  end
  context "autosave_associated_records_for_van" do
    it "exercises autosave_associated_records_for_van somehow" do
      subject.autosave_associated_records_for_van 
    end
  end

end
