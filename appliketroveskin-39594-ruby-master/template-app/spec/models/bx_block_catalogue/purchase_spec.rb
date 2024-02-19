require 'rails_helper'

RSpec.describe BxBlockCatalogue::Purchase, type: :model do
  let (:subject) { build :purchase }
  context "validation" do
    # it { should validate_presence_of :recommended_product }
    it "exclusion_validator test for [:quantity]" do
      should validate_exclusion_of(:quantity).in_array(['0'])
    end
  end
  context "associations" do
    it { should belong_to :recommended_product }
  end
  context "autosave_associated_records_for_recommended_product" do
    it "exercises autosave_associated_records_for_recommended_product somehow" do
      subject.autosave_associated_records_for_recommended_product 
    end
  end
end
