module AccountBlock
    class TherapistNote < ApplicationRecord
        self.table_name = :therapist_notes

        belongs_to :therapist, polymorphic: true
        belongs_to :account, class_name: 'AccountBlock::Account'
    end
end
