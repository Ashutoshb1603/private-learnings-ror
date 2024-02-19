class CreateBxBlockCategoriesHiddenPlaceWeathers < ActiveRecord::Migration[6.0]
  def change
    create_table :hidden_place_weathers do |t|
      t.references :hidden_place, null: false, foreign_key: true
      t.references :weathers, null: false, foreign_key: true

      t.timestamps
    end
  end
end
