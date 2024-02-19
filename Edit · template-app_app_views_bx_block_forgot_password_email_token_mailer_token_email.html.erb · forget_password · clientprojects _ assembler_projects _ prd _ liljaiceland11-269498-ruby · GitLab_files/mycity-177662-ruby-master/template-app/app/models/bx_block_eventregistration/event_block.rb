module BxBlockEventregistration
    class EventBlock < ApplicationRecord
        self.table_name = :event_blocks

        attr_accessor :start_time, :end_time

        validates :event_name, :location, :start_date_and_time, :end_date_and_time,
                  :start_time, :end_time, :description, :images, presence: true
                  
        has_many_attached :images

        has_many :account_event_blocks, class_name: "BxBlockEventregistration::AccountEventBlock"
        has_many :accounts, through: :account_event_blocks, class_name: "AccountBlock::Account"

        before_validation :set_date_time

        def set_date_time
            return if start_date_and_time.nil? || start_time&.strip!.nil?
            
            self.start_date_and_time = start_date_and_time.to_date + parse_time(start_time)
            return if end_date_and_time.nil? || end_time&.strip!.nil?

            self.end_date_and_time = end_date_and_time.to_date + parse_time(end_time)
        end

        def parse_time(time)
            Time.zone.parse(time).seconds_since_midnight.seconds
        end
    end
end
