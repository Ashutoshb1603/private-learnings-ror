require 'rails_helper'

describe BxBlockContentmanagement::KeyPoint, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/key_point }
  # # context "validation" do
  # #   it { should validate_presence_of :academy }
  # end
  context "associations" do
    it { should belong_to :academy }
  end
  context "autosave_associated_records_for_academy" do
    it "exercises autosave_associated_records_for_academy somehow" do
      subject.autosave_associated_records_for_academy 
    end
  end

end
