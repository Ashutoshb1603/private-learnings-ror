module BxBlockCommunityforum
    class Saved < ApplicationRecord
        self.table_name = :saved

        # belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :accountable, polymorphic: true
        belongs_to :question, class_name: 'BxBlockCommunityforum::Question'
    end
end