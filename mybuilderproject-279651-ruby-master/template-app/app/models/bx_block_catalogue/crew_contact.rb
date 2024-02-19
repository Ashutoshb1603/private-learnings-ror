module BxBlockCatalogue
  class CrewContact < BxBlockCatalogue::ApplicationRecord
    self.table_name = :crew_contacts
    belongs_to :crew
  end
end
