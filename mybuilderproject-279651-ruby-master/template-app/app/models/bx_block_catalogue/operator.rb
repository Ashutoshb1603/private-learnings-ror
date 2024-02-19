module BxBlockCatalogue
  class Operator < BxBlockCatalogue::ApplicationRecord
    self.table_name = :operators
    has_many :aircrafts
  end
end
