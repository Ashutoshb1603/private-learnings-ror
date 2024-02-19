require 'rails_helper'

describe AccountBlock::KlaviyoList, :type => :model do
  # let (:subject) { build :account_block/klaviyo_list }
  # context "validation" do
  #   it { should validate_presence_of :account }
  # end
  context "associations" do
    it { should belong_to :account }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end

end
