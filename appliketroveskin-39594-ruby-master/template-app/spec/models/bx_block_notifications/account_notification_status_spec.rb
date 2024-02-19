require 'rails_helper'

describe BxBlockNotifications::AccountNotificationStatus, :type => :model do
  # let (:subject) { build :bx_block_notifications/account_notification_status }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :notification_type }
  # end
  context "associations" do
    it { should belong_to :account }
    it { should belong_to :notification_type }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_notification_type" do
    it "exercises autosave_associated_records_for_notification_type somehow" do
      subject.autosave_associated_records_for_notification_type 
    end
  end

end
