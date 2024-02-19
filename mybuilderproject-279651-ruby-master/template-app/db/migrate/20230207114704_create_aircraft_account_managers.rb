class CreateAircraftAccountManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :aircraft_account_managers do |t|
    	t.string :external_reference
    	t.string :first_name
    	t.string :last_name
    	t.string :log_name
    	t.string :gender
    	t.string :status
    	t.string :salutation
    	t.bigint :internal_id
    	t.bigint :aircraft_id

      t.timestamps
    end
  end
end
