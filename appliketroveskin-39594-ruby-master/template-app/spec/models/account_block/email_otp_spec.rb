require 'rails_helper'

describe AccountBlock::EmailOtp, :type => :model do
  # let (:subject) { build :account_block/email_otp }
  context "validation" do
    it  "should validate presence of email" do
      email_otp = build :email_otp
      expect(email_otp).to validate_presence_of :email
    end
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

end
