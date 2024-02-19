module BxBlockExplanationText
  class ExplanationTextSerializer < BuilderBase::BaseSerializer
    attributes :id, :section_name, :area_name, :value, :created_at, :updated_at
  end
end