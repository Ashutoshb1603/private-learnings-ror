class CreateJoinTablePlacesWeathers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :hidden_places, :weathers do |t|
      t.index [:hidden_place_id, :weather_id], name: 'idx_place_weather'
      t.index [:weather_id, :hidden_place_id], name: 'idx_weather_places'
    end
  end
end
