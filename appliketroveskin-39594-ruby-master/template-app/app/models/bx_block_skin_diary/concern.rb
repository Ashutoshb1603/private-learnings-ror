module BxBlockSkinDiary
    class Concern < ApplicationRecord
        self.table_name = :concerns
        has_many :skin_stories
    end
end
