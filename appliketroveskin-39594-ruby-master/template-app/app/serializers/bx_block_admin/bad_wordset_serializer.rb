module BxBlockAdmin
  class BadWordsetSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :words, :updated_at
  end
end
