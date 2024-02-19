module BxBlockCategories
  class HiddenPlaceWeather < ApplicationRecord
    self.table_name = :hidden_place_weathers
    
    belongs_to :hidden_place, class_name: "BxBlockHiddenPlaces::HiddenPlace", optional: true
    belongs_to :weather, class_name: "BxBlockCategories::Weather", optional: true
  end
end
