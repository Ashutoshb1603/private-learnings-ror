class CreateCrewAircrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :crew_aircrafts do |t|
    	t.bigint :crew_id
    	t.string :aircraft_name
    	t.string :registration
    	t.string :status
    	t.string :last_warning
    	t.string :first_warning

    	t.timestamps
    end
  end
end
