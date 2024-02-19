module BxBlockCommunityforum
    class View < ApplicationRecord
        self.table_name = :views

        belongs_to :question, class_name: 'BxBlockCommunityforum::Question'
        # belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :accountable, polymorphic: true
    end
end
