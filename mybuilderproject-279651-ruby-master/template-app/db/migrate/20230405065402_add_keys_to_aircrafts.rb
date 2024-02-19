class AddKeysToAircrafts < ActiveRecord::Migration[6.0]
  def change
    add_column :aircrafts, :aircraft_base_easa, :string
    add_column :aircrafts, :is_aircraft, :boolean
    add_column :aircrafts, :is_helicopter, :boolean
    add_column :aircrafts, :data_source, :integer
  end
end
