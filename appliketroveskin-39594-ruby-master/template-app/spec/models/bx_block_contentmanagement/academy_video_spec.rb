require 'rails_helper'

describe BxBlockContentmanagement::AcademyVideo, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/academy_video }
  context "validation" do
    # it { should validate_presence_of :academy }
    # it "format_validator test for [:url]"
  end
  context "associations" do
    it { should belong_to :academy }
  end
  context "autosave_associated_records_for_academy" do
    it "exercises autosave_associated_records_for_academy somehow" do
      subject.autosave_associated_records_for_academy 
    end
  end

end
