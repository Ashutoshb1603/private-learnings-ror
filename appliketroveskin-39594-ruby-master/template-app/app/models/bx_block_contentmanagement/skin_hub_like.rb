module BxBlockContentmanagement
    class SkinHubLike < ApplicationRecord
        self.table_name = :skin_hub_likes
        belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :objectable, polymorphic: true
    end
end
