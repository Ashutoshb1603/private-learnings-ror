module BxBlockCatalogue
  class AviAircraft < BxBlockCatalogue::ApplicationRecord
    self.table_name = :avi_aircrafts
    # has_one :aircraft_equipment, dependent: :destroy
    # has_many :aircraft_links, dependent: :destroy
    # has_one :aircraft_account_manager, dependent: :destroy
  end
end
