module BxBlockPayments
    class Subscription < ApplicationRecord
        self.table_name = :subscriptions
        belongs_to :account, class_name: 'AccountBlock::Account'

        enum currency: { 'eur' => 1, 'gbp' => 2 }
    end
end