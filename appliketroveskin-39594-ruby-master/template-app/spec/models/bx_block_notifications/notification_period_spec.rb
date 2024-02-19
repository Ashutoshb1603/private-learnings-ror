require 'rails_helper'

describe BxBlockNotifications::NotificationPeriod, :type => :model do
  # let (:subject) { build :bx_block_notifications/notification_period }
  context "validation" do
    it { should validate_presence_of :notification_type }
    it { should validate_presence_of :period_type }
    it { should validate_presence_of :period }
  end
  context "associations" do
  end
  context "get_cronjob_period" do
    it "exercises get_cronjob_period somehow" do
      subject.get_cronjob_period 
    end
  end
  context "validate_notification_period" do
    it "exercises validate_notification_period somehow" do
      subject.validate_notification_period 
    end
  end

end
