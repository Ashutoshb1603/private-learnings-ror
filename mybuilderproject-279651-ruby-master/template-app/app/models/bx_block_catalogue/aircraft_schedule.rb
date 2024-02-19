module BxBlockCatalogue
  class AircraftSchedule < BxBlockCatalogue::ApplicationRecord
    self.table_name = :aircraft_schedules
    belongs_to :aircraft
  end
end
