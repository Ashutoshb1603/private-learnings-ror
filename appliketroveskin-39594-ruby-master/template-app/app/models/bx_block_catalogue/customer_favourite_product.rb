module BxBlockCatalogue
    class CustomerFavouriteProduct < ApplicationRecord
        self.table_name = :customer_favourite_products

        belongs_to :account, polymorphic: true
    end
end
