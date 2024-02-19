require 'rails_helper'

describe BxBlockCommunityforum::Activity, :type => :model do
  # let (:subject) { build :bx_block_communityforum/activity }
  # context "validation" do
  #   it { should validate_presence_of :accountable }
  #   it { should validate_presence_of :objectable }
  # end
  context "associations" do
    it { should belong_to :accountable }
    it { should belong_to :objectable }
    # it { should belong_to :user_activity }
  end
  context "autosave_associated_records_for_accountable" do
    it "exercises autosave_associated_records_for_accountable somehow" do
      subject.autosave_associated_records_for_accountable 
    end
  end
  context "autosave_associated_records_for_objectable" do
    it "exercises autosave_associated_records_for_objectable somehow" do
      subject.autosave_associated_records_for_objectable 
    end
  end
  context "autosave_associated_records_for_user_activity" do
    it "exercises autosave_associated_records_for_user_activity somehow" do
      subject.autosave_associated_records_for_user_activity 
    end
  end
  # context "send_notification" do
  #   it "exercises send_notification somehow" do
  #     subject.send_notification 
  #   end
  # end

end
