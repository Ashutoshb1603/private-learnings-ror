class CreateAirports < ActiveRecord::Migration[6.0]
  def change
    create_table :airports do |t|
    	t.string :iata
    	t.string :icao
    	t.string :faa
    	t.string :airport_name
    	t.string :city
    	t.string :subdivision_name
    	t.string :country_name
    	t.string :iso_country_name
    	t.string :airport_of_entry
    	t.string :last_edited

    	t.timestamps
    end
  end
end
