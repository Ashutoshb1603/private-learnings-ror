module BxBlockCatalogue
    class DeleteDuplicateData
        class << self
            def call
                ids = BxBlockCatalogue::RecommendedProduct.group('account_id, therapist_id, product_id').pluck('MIN(id)')
                BxBlockCatalogue::RecommendedProduct.where.not(id: ids).destroy_all
            end
        end
    end
end