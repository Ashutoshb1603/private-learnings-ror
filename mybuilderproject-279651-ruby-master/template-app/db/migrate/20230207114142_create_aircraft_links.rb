class CreateAircraftLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :aircraft_links do |t|
    	t.string :rel
    	t.string :link_url
    	t.bigint :aircraft_id

      t.timestamps
    end
  end
end
