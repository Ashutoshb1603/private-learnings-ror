module BxBlockCatalogue
  class ProductCollectionView < ApplicationRecord
    self.table_name = :collection_views
    belongs_to :accountable, polymorphic: true
  end
end
