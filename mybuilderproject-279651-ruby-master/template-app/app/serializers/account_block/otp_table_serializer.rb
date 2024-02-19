module AccountBlock
  class OtpTableSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_type, :pin, :email,:full_phone_number, :activated
  end
end
