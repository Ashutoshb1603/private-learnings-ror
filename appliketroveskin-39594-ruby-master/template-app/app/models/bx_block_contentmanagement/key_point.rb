module BxBlockContentmanagement
    class KeyPoint < ApplicationRecord
        self.table_name = :key_points

        belongs_to :academy, class_name: 'BxBlockContentmanagement::Academy'
    end
end
