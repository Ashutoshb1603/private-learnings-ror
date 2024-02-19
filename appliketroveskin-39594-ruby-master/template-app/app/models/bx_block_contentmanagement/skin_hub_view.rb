module BxBlockContentmanagement
    class SkinHubView < ApplicationRecord
        self.table_name = :skin_hub_views

        belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :objectable, polymorphic: true
    end
end
