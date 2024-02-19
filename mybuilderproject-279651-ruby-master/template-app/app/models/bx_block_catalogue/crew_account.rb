module BxBlockCatalogue
  class CrewAccount < BxBlockCatalogue::ApplicationRecord
    self.table_name = :crew_accounts
    belongs_to :crew
  end
end
