module BxBlockCatalogue
  class AircraftAccountManager < BxBlockCatalogue::ApplicationRecord
    self.table_name = :aircraft_account_managers
    belongs_to :aircraft
  end
end
