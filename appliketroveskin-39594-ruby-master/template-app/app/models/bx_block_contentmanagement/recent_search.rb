module BxBlockContentmanagement
    class RecentSearch < ApplicationRecord
        self.table_name = :recent_searches
        belongs_to :account, class_name: 'AccountBlock::Account'
    end
end