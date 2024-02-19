require 'rails_helper'

describe BxBlockNotifications::NotificationType, :type => :model do
  # let (:subject) { build :bx_block_notifications/notification_type }
  context "validation" do
  end
  context "associations" do
    it { should have_many :account_notification_statuses }
  end
  context "after_add_for_account_notification_statuses" do
    it "exercises after_add_for_account_notification_statuses somehow" do
      subject.after_add_for_account_notification_statuses 
    end
  end
  context "after_add_for_account_notification_statuses=" do
    it "exercises after_add_for_account_notification_statuses= somehow" do
      subject.after_add_for_account_notification_statuses= 1
    end
  end
  context "after_add_for_account_notification_statuses?" do
    it "exercises after_add_for_account_notification_statuses? somehow" do
      subject.after_add_for_account_notification_statuses? 
    end
  end
  context "after_remove_for_account_notification_statuses" do
    it "exercises after_remove_for_account_notification_statuses somehow" do
      subject.after_remove_for_account_notification_statuses 
    end
  end
  context "after_remove_for_account_notification_statuses=" do
    it "exercises after_remove_for_account_notification_statuses= somehow" do
      subject.after_remove_for_account_notification_statuses= 1
    end
  end
  context "after_remove_for_account_notification_statuses?" do
    it "exercises after_remove_for_account_notification_statuses? somehow" do
      subject.after_remove_for_account_notification_statuses? 
    end
  end
  context "autosave_associated_records_for_account_notification_statuses" do
    it "exercises autosave_associated_records_for_account_notification_statuses somehow" do
      subject.autosave_associated_records_for_account_notification_statuses 
    end
  end
  context "before_add_for_account_notification_statuses" do
    it "exercises before_add_for_account_notification_statuses somehow" do
      subject.before_add_for_account_notification_statuses 
    end
  end
  context "before_add_for_account_notification_statuses=" do
    it "exercises before_add_for_account_notification_statuses= somehow" do
      subject.before_add_for_account_notification_statuses= 1
    end
  end
  context "before_add_for_account_notification_statuses?" do
    it "exercises before_add_for_account_notification_statuses? somehow" do
      subject.before_add_for_account_notification_statuses? 
    end
  end
  context "before_remove_for_account_notification_statuses" do
    it "exercises before_remove_for_account_notification_statuses somehow" do
      subject.before_remove_for_account_notification_statuses 
    end
  end
  context "before_remove_for_account_notification_statuses=" do
    it "exercises before_remove_for_account_notification_statuses= somehow" do
      subject.before_remove_for_account_notification_statuses= 1
    end
  end
  context "before_remove_for_account_notification_statuses?" do
    it "exercises before_remove_for_account_notification_statuses? somehow" do
      subject.before_remove_for_account_notification_statuses? 
    end
  end
  context "validate_associated_records_for_account_notification_statuses" do
    it "exercises validate_associated_records_for_account_notification_statuses somehow" do
      subject.validate_associated_records_for_account_notification_statuses 
    end
  end

end
