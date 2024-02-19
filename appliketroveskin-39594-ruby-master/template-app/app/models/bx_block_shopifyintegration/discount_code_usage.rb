module BxBlockShopifyintegration
    class DiscountCodeUsage < ApplicationRecord
        self.table_name = :discount_code_usages

        belongs_to :account, class_name: "AccountBlock::Account"
        belongs_to :order, class_name: "BxBlockShoppingCart::Order"

        enum value_type: {'percentage': 1, 'fixed_amount': 2}
    end
end
