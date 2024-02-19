require 'rails_helper'

describe AccountBlock::SmsOtp, :type => :model do
  # let (:subject) { build :sms_otp }
  context "validation" do
    it { should validate_presence_of :full_phone_number }
  end
  context "associations" do
  end
  context "generate_pin_and_valid_date" do
    it "exercises generate_pin_and_valid_date somehow" do
      subject.generate_pin_and_valid_date 
    end
  end
  context "phone" do
    it "exercises phone somehow" do
      subject.phone 
    end
  end
  # context "send_pin_via_sms" do
  #   it "exercises send_pin_via_sms somehow" do
  #     subject.send_pin_via_sms 
  #   end
  # end

end
