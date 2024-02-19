module BxBlockAutomaticRenewals
    class AutomaticRenewal < ApplicationRecord
        self.table_name = :automatic_renewals

        belongs_to :account, class_name: 'AccountBlock::Account'

        validates :account_id, :subscription_type, presence: true
    end
end
