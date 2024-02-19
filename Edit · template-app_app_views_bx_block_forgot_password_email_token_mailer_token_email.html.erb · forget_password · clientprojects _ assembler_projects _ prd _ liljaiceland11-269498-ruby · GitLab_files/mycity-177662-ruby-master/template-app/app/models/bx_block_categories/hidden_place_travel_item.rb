module BxBlockCategories
  class HiddenPlaceTravelItem < ApplicationRecord
    self.table_name = :hidden_place_travel_items
    belongs_to :hidden_place,class_name: "BxBlockHiddenPlaces::HiddenPlace", optional: true
    belongs_to :travel_item,class_name: "BxBlockCategories::TravelItem",optional: true
  end
end
