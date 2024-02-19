module BxBlockClubEvents
  class EventTravelItem < BxBlockClubEvents::ApplicationRecord
    self.table_name = :event_travel_items

    belongs_to :club_event, class_name: "BxBlockClubEvents::ClubEvent"
    belongs_to :travel_item, class_name: "BxBlockCategories::TravelItem"
  end
end
