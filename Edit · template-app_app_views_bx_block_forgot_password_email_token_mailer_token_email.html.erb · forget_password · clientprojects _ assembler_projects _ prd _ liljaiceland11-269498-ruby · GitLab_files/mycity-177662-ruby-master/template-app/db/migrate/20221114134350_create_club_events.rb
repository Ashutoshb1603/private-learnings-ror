class CreateClubEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :club_events do |t|
      t.integer :social_club_id
      t.string :event_name
      t.string :location
      t.boolean :is_visible, default: false
      t.datetime :start_date_and_time
      t.datetime :end_date_and_time
      t.integer :activity_ids, array:true, default:[]
      t.integer :equipment_ids, array:true, default:[]
      t.integer :max_participants
      t.integer :min_participants
      t.string :fee_currency
      t.decimal :fee_amount_cents, precision: 8, scale: 2
      t.text :description
      t.integer :age_should_be
      t.integer :status, default: 0

      t.timestamps
    end
  end
end


