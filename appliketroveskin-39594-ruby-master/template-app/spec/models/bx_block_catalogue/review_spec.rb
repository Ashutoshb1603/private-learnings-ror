require 'rails_helper'

describe BxBlockCatalogue::Review, :type => :model do
  # let (:subject) { build :bx_block_catalogue/review }
  # context "validation" do
  #   it { should validate_presence_of :catalogue }
  # end
  context "associations" do
    it { should belong_to :catalogue }
  end
  context "autosave_associated_records_for_catalogue" do
    it "exercises autosave_associated_records_for_catalogue somehow" do
      subject.autosave_associated_records_for_catalogue 
    end
  end

end
