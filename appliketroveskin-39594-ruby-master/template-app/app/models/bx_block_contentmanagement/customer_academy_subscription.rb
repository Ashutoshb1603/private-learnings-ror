module BxBlockContentmanagement
    class CustomerAcademySubscription < ApplicationRecord
        self.table_name = :customer_academy_subscriptions

        belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :academy, class_name: 'BxBlockContentmanagement::Academy'

        
    end
end
