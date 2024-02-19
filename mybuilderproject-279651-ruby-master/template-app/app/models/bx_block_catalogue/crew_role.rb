module BxBlockCatalogue
  class CrewRole < BxBlockCatalogue::ApplicationRecord
    self.table_name = :crew_roles
    belongs_to :crew
  end
end
