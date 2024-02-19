class CreateEventBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :event_blocks do |t|
      t.string :event_name
      t.string :location
      t.datetime :start_date_and_time
      t.datetime :end_date_and_time
      t.text :description
      
      t.timestamps
    end
  end
end
