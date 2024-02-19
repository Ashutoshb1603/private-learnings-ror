module AccountBlock
  class EmailOtpSerializer < BuilderBase::BaseSerializer
      attributes :user_type, :pin, :email, :activated
  end
end