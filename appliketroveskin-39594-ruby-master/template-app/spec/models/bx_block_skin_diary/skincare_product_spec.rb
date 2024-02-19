require 'rails_helper'

describe BxBlockSkinDiary::SkincareProduct, :type => :model do
  # let (:subject) { build :bx_block_skin_diary/skincare_product }
  # context "validation" do
  #   it { should validate_presence_of :skincare_step }
  # end
  context "associations" do
    it { should belong_to :skincare_step }
  end
  context "autosave_associated_records_for_skincare_step" do
    it "exercises autosave_associated_records_for_skincare_step somehow" do
      subject.autosave_associated_records_for_skincare_step 
    end
  end

end
