module BxBlockCatalogue
  class CrewPreference < BxBlockCatalogue::ApplicationRecord
    self.table_name = :crew_preferences
    belongs_to :crew
  end
end
