module BxBlockCatalogue
    class ProductKey < ApplicationRecord
        self.table_name = :product_keys

        enum location: {'Ireland': 1, 'Uk': 2}
    end
end
