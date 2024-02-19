module BxBlockCategories
  class HiddenPlaceActivity < ApplicationRecord
    self.table_name = :hidden_place_activities
    
    belongs_to :hidden_place, class_name: "BxBlockHiddenPlaces::HiddenPlace", optional: true
    belongs_to :activity, class_name: "BxBlockCategories::Activity", optional: true
  end
end
