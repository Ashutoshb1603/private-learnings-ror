class CreateAircrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :aircrafts do |t|
      t.string :tail_number
      t.string :aircraft_type
      t.string :model
      t.string :type_name
      t.string :homebase
      t.float :wing_span
      t.float :max_fuel
      t.float :external_length
      t.float :external_height
      t.float :cabin_height
      t.float :cabin_length
      t.float :cabin_width
      t.bigint :category_id
      t.string :flight_number_token
      t.boolean :subcharter
      t.boolean :cargo
      t.boolean :ambulance
      t.string :type_rating
      t.string :type_of_use
      t.integer :number_of_seats
      t.integer :cabin_crew
      t.integer :flight_crew
      t.integer :onboard_engineer

      t.timestamps
    end
  end
end
