module BxBlockAdmin
  class UserSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :name, :full_phone_number, :country_code, :phone_number, :email, :gender, :activated, :device
  end
end