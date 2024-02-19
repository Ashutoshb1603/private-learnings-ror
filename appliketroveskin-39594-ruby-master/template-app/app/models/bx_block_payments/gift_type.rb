module BxBlockPayments
    class GiftType < ApplicationRecord
        self.table_name = :gift_types

        has_many :wallet_transactions, class_name: 'BxBlockPayments::WalletTransaction'
        has_one_attached :free_user_image
        has_one_attached :gg_user_image

        enum status: {'active': 1, 'inactive': 2}
    end
end
