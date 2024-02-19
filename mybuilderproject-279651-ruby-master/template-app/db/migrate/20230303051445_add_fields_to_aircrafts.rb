class AddFieldsToAircrafts < ActiveRecord::Migration[6.0]
  def change
  	add_column :aircrafts, :year_of_manufacture, :string
  	add_column :aircrafts, :year_of_exterior_refurbishment, :string
  	add_column :aircrafts, :year_of_interior_refurbishment, :string
  	add_column :aircrafts, :aircraft_base_country, :string
  	add_column :aircrafts, :aircraft_base_iata, :string
  	add_column :aircrafts, :aircraft_base_icao, :string
  	add_column :aircrafts, :aircraft_serial_number, :string
  	add_column :aircrafts, :aircraft_country_of_registration, :string
  	add_column :aircrafts, :make, :string
  	add_column :aircrafts, :luggage_volume, :string
  	add_column :aircrafts, :entertainment, :string
  	add_column :aircrafts, :interior_accessories, :string
  	add_column :aircrafts, :is_file_imported, :boolean, default: false
  end
end
