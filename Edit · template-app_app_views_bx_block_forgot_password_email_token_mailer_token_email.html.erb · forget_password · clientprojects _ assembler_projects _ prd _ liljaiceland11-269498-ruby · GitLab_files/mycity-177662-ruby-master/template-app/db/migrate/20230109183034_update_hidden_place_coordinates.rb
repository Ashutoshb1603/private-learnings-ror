class UpdateHiddenPlaceCoordinates < ActiveRecord::Migration[6.0]
  def change
    BxBlockHiddenPlaces::HiddenPlace.where('google_map_link IS NOT NULL').each do |hidden_place|
      hidden_place = hidden_place.generate_coordinates
      hidden_place.save
    end
  end
end
