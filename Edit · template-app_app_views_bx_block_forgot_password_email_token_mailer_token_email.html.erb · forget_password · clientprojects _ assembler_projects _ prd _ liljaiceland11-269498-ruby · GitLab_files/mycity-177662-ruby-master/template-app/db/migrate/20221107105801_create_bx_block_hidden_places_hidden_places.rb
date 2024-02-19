class CreateBxBlockHiddenPlacesHiddenPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :hidden_places do |t|
      t.references :account, null: false, foreign_key: true
      t.string :place_name
      t.string :google_map_link
      t.text :description

      t.timestamps
    end
  end
end
