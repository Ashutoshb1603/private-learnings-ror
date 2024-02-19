class CreateAirportCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :airport_charges do |t|
    	t.string :origin_airport
    	t.string :destination_airport
    	t.string :mtow
    	t.string :pax
    	t.datetime :arrival_time
    	t.datetime :departure_time
    	t.string :equipment
    	t.string :sub_total
    	t.string :sub_total_currency
    	t.json :origin_charge_data
    	t.json :destination_charge_data
    	t.json :exchange_rate_data
      t.timestamps
    end
  end
end
