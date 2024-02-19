module BxBlockConsultation
  class ConsultationTypeSerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :price, :description, :created_at, :updated_at
  end
end