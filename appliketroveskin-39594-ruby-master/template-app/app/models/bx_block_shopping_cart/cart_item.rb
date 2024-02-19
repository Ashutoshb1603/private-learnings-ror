module BxBlockShoppingCart
    class CartItem < ApplicationRecord
        self.table_name = :cart_items
        include Wisper::Publisher

        belongs_to :account, class_name: 'AccountBlock::Account'

    end 
end
