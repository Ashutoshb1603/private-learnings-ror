module AccountBlock
    class InfoText < ApplicationRecord
        self.table_name = :info_texts
        enum screen: {'life_event': 1}

        validates_uniqueness_of :screen
    end
end
