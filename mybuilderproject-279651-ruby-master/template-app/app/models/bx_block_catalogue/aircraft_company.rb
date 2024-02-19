module BxBlockCatalogue
  class AircraftCompany < BxBlockCatalogue::ApplicationRecord
    self.table_name = :aircraft_companies
    belongs_to :aircraft
  end
end
