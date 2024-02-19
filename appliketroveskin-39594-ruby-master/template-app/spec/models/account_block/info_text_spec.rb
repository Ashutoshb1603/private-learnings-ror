require 'rails_helper'

describe AccountBlock::InfoText, :type => :model do
  # let (:subject) { build :account_block/info_text }
  context "validation" do
    it "uniqueness_validator test for [:screen]" do
      info_text = create :info_text
      count = AccountBlock::InfoText.pluck(:screen).count
      expect(count).to be_equal(1)
    end
  end

  context "associations" do
  end
end
