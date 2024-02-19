class CreateBxBlockCategoriesHiddenPlaceTravelItems < ActiveRecord::Migration[6.0]
  def change
    create_table :hidden_place_travel_items do |t|
      t.references :hidden_place, null: false, foreign_key: true
      t.references :travel_items, null: false, foreign_key: true

      t.timestamps
    end
  end
end
