class AddCoordinatesColumnsInPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :hidden_places, :latitude, :float
    add_column :hidden_places, :longitude, :float

    add_index :hidden_places, [:latitude, :longitude]
  end
end
