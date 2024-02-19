module BxBlockShoppingCart
    class LineItem < ApplicationRecord
        self.table_name = :line_items

        belongs_to :order, class_name: "BxBlockShoppingCart::Order"
    end
end
