require 'rails_helper'

describe BxBlockContentmanagement::CustomerAcademySubscription, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/customer_academy_subscription }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :academy }
  # end
  context "associations" do
    it { should belong_to :account }
    it { should belong_to :academy }
  end
  context "autosave_associated_records_for_academy" do
    it "exercises autosave_associated_records_for_academy somehow" do
      subject.autosave_associated_records_for_academy 
    end
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end

end
