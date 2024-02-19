class RemoveImagesHiddenPlaces < ActiveRecord::Migration[6.0]
  def change
    BxBlockHiddenPlaces::HiddenPlace.all.each do |place|
      unless place.images.attached?
        BxBlockCategories::HiddenPlaceActivity.destroy_all
        BxBlockCategories::HiddenPlaceTravelItem.destroy_all
        BxBlockCategories::HiddenPlaceWeather.destroy_all
        
      	place.activities.destroy_all
      	place.travel_items.destroy_all
      	place.weathers.destroy_all
        place.destroy
      end
    end
  end
end
