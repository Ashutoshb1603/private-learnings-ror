class CreateJoinTablePlacesTravelItems < ActiveRecord::Migration[6.0]
  def change
    create_join_table :hidden_places, :travel_items do |t|
      t.index [:hidden_place_id, :travel_item_id], name: 'idx_place_travel_items'
      t.index [:travel_item_id, :hidden_place_id], name: 'idx_travel_items_place'
    end
  end
end
