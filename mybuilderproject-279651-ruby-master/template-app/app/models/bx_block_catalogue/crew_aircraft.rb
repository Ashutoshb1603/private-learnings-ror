module BxBlockCatalogue
  class CrewAircraft < BxBlockCatalogue::ApplicationRecord
    self.table_name = :crew_aircrafts
    belongs_to :crew
  end
end
