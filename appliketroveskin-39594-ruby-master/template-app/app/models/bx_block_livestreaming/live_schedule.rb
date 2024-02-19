module BxBlockLivestreaming
    class LiveSchedule < ApplicationRecord
        self.table_name = 'live_schedules'
        
        enum status: {
            upcoming: 1,
            live: 2,
            completed: 3
        }
        
    end
end
