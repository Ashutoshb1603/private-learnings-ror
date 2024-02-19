require 'rails_helper'

describe BxBlockContentmanagement::HomePageView, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/home_page_view }
  # context "validation" do
  #   it { should validate_presence_of :accountable }
  # end
  context "associations" do
    it { should belong_to :accountable }
  end
  context "autosave_associated_records_for_accountable" do
    it "exercises autosave_associated_records_for_accountable somehow" do
      subject.autosave_associated_records_for_accountable 
    end
  end

end
