class CreateBxBlockCategoriesHiddenPlaceActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :hidden_place_activities do |t|
      t.references :hidden_place, null: false, foreign_key: true
      t.references :activities, null: false, foreign_key: true

      t.timestamps
    end
  end
end
