module BxBlockCatalogue
  class AircraftLink < BxBlockCatalogue::ApplicationRecord
    self.table_name = :aircraft_links
    belongs_to :aircraft
    has_one_attached :picture
  end
end
