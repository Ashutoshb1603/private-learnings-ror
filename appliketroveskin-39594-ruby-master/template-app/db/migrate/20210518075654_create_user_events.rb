class CreateUserEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_events do |t|
      t.references :life_event, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.date :event_date

      t.timestamps
    end
  end
end
