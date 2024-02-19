module BxBlockEquipments
    class EquipmentSerializer < BuilderBase::BaseSerializer
      include JSONAPI::Serializer
      attributes *[:name]
    end
  end