class ChangeColumnNameOfHiddenPlaceActivity < ActiveRecord::Migration[6.0]
  def change
    rename_column :hidden_place_activities, :activities_id, :activity_id
    rename_column :hidden_place_travel_items, :travel_items_id, :travel_item_id
    rename_column :hidden_place_weathers, :weathers_id, :weather_id

  end
end
