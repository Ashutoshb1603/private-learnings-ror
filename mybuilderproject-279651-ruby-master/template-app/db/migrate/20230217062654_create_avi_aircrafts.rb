class CreateAviAircrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :avi_aircrafts do |t|

    t.integer :aircraft_id
    t.string :tail_number
    t.string :aircraft_type_name
    t.string :aircraft_class_name
    t.integer:max_passengers
    t.integer :serial_number
    t.integer :company_id
	  t.string :company_name
	  t.integer :year_of_production
	  t.string :manufacturer_name
	  t.string :cabin_crew
	  t.string :lavatory
	  t.string :hot_meal
	  t.boolean :is_for_charter
	  t.boolean :is_for_sale
	  t.string :wireless_internet
	  t.string :entertainment_system
	  t.string :medical_ramp
	  t.string :adult_critical_care
	  t.string :pediatric_critical_care
	  t.string :smoking
	  t.string :pets_allowed
	  t.string :shower
	  t.string :satellite_phone
	  t.string :owners_approval_required
	  t.string :refurbishment_year
	  t.string :view_360
	  t.string :divan_seats
	  t.string :beds
	  t.string :sleeping_places
    t.string :country_name
    t.string :city_name
    t.string :slug
    t.float :cabin_height
    t.float :cabin_length
    t.float :cabin_width
    t.boolean :is_active
    t.timestamps
    end
  end
end
