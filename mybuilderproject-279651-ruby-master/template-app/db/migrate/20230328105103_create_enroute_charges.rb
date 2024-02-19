class CreateEnrouteCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :enroute_charges do |t|
    	t.string :origin_airport
    	t.string :destination_airport
    	t.integer :mtow
    	t.datetime :date
    	t.float :sub_total
    	t.string :sub_total_currency
    	t.float :total_distance_flown_in_km
    	t.json :enroute_charge_data
    	t.json :exchange_rate_data
    	t.json :information_data
      t.timestamps
    end
  end
end
