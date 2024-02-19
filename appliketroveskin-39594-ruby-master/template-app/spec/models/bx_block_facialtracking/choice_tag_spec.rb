require 'rails_helper'

describe BxBlockFacialtracking::ChoiceTag, :type => :model do
  # let (:subject) { build :bx_block_facialtracking/choice_tag }
  # context "validation" do
  #   it { should validate_presence_of :choice }
  #   it { should validate_presence_of :tag }
  # end
  context "associations" do
    it { should belong_to :choice }
    it { should belong_to :tag }
  end
  context "autosave_associated_records_for_choice" do
    it "exercises autosave_associated_records_for_choice somehow" do
      subject.autosave_associated_records_for_choice 
    end
  end
  context "autosave_associated_records_for_tag" do
    it "exercises autosave_associated_records_for_tag somehow" do
      subject.autosave_associated_records_for_tag 
    end
  end

end
