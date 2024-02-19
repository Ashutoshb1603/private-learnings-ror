module BxBlockCatalogue
  class Review < BxBlockCatalogue::ApplicationRecord
    self.table_name = :reviews

    belongs_to :catalogue
  end
end
