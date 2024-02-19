class CreateCrewPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :crew_preferences do |t|
    	t.string :description
    	t.string :template_name
    	t.integer :order
    	t.boolean :template_show_in_pax
    	t.boolean :template_show_in_catering
    	t.boolean :template_show_in_sales
    	t.boolean :template_show_as_important
    	t.bigint :crew_id

    	t.timestamps
    end
  end
end
