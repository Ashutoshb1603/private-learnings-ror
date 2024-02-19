module AccountBlock
  class SmsOtpSerializer < BuilderBase::BaseSerializer
  	attributes :user_type, :full_phone_number, :pin, :activated
  end
end
