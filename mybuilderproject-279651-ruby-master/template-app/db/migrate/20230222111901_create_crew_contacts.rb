class CreateCrewContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :crew_contacts do |t|
    	t.bigint :crew_id
    	t.bigint :flex_contact_id
    	t.string :data
    	t.string :contact_type
    	t.boolean :mains
    	t.boolean :deleted

    	t.timestamps
    end
  end
end
