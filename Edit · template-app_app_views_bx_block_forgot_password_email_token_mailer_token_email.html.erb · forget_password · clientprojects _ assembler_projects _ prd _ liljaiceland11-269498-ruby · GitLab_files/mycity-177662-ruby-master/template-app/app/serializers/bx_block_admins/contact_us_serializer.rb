module BxBlockAdmins
  class ContactUsSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :name, :email, :description
  end
end
