module BxBlockFacialtracking
    class SkinJourney < ApplicationRecord
        self.table_name = :skin_journeys
        belongs_to :therapist, polymorphic: true
        belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: :account_id
    end
end
