class CreateAircraftSchedule < ActiveRecord::Migration[6.0]
  def change
    create_table :aircraft_schedules do |t|
    	t.string :schedule_id
    	t.string :departure_airport
    	t.string :arrival_airport
    	t.datetime :arrival_date
    	t.datetime :arrival_date_utc
    	t.datetime :departure_date
    	t.datetime :departure_date_utc
    	t.integer :pax
    	t.integer :trip_number
    	t.string :workflow
    	t.string :fpl_type
    	t.string :workflow_custom_name
    	t.bigint :aircraft_id

    	t.timestamps
    end
  end
end
