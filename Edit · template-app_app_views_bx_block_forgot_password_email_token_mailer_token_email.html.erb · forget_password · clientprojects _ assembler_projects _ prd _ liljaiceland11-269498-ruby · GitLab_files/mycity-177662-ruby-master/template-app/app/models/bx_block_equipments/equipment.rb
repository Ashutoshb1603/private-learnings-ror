module BxBlockEquipments
    class Equipment < ApplicationRecord
        self.table_name = :equipments            
        
        has_and_belongs_to_many :club_events, class_name: "BxBlockClubEvents::ClubEvent"

        validates :name, presence: true
        
        enum status: %i(draft approved archieved deleted)
    end
end
