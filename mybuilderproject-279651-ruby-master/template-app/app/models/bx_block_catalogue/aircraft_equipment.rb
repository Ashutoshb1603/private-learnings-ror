module BxBlockCatalogue
  class AircraftEquipment < BxBlockCatalogue::ApplicationRecord
    self.table_name = :aircraft_equipments
    belongs_to :aircraft
  end
end
