module BxBlockCatalogue
    class Purchase < ApplicationRecord
        self.table_name = :purchases
        belongs_to :recommended_product, class_name: 'BxBlockCatalogue::RecommendedProduct', optional: false
        validates :quantity, exclusion: { in: [0] }
        scope :filter_by_date, -> (date) {where(created_at: date)}
    end
end
