class CreateAircraftCompany < ActiveRecord::Migration[6.0]
  def change
    create_table :aircraft_companies do |t|
    	t.string :company_name
    	t.string :company_location
    	t.string :company_address
    	t.string :company_city
    	t.string :company_state
    	t.string :company_zipcode
    	t.string :company_web_address
    	t.string :company_phone
    	t.string :company_fax
    	t.bigint :aircraft_id

    	t.timestamps
    end
  end
end
