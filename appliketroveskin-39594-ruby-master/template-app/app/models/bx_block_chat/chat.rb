module BxBlockChat
    class Chat < ApplicationRecord
        self.table_name = :chats

        enum status: {active: 1, inactive: 2}
        belongs_to :account, class_name: "AccountBlock::Account"
        belongs_to :therapist, polymorphic: true, foreign_key: 'therapist_id'

        has_many :messages, class_name: "BxBlockChat::Message", dependent: :destroy

        before_create :add_start_and_end_time

        def add_start_and_end_time
            self.start_date = Time.now
            self.end_date = 8.weeks.after.end_of_day
        end
    end
end
