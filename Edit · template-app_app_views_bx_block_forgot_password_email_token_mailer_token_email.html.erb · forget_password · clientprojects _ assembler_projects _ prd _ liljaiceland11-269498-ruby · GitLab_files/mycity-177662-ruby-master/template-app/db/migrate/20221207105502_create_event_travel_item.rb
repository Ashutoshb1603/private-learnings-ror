class CreateEventTravelItem < ActiveRecord::Migration[6.0]
  def change
    create_table :event_travel_items do |t|
      t.references :travel_item, null: false, foreign_key: true
      t.references :club_event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
