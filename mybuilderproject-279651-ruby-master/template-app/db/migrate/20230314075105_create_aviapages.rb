class CreateAviapages < ActiveRecord::Migration[6.0]
  def change
    create_table :aviapages do |t|
      t.string :fuel
      t.integer :fuel_airway
      t.integer :fuel_airway_block
    	t.string :time
      t.integer :time_airway
    	t.string :route
      t.string :ifr_route
    	t.string :airport
      t.string :arrival_airport
    	t.string :departure_airport
      t.string :aircraft
      t.string :distance
    	t.float :distance_airway
    	t.timestamps
    end
  end
end
