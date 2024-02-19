class CreateCrewRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :crew_roles do |t|
    	t.bigint :crew_id
    	t.bigint :role_id
    	t.string :role_type
    	t.string :mandatory_id
    	t.string :label
    	t.integer :role_order
    	t.integer :filter_id
    	t.boolean :to_display
    	t.boolean :roster_filter

    	t.timestamps
    end
  end
end
