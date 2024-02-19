class CreateLiveSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :live_schedules do |t|
      t.datetime :at
      t.string :guest_email
      t.string :user_type
      t.boolean :event_creation_notification, :default => false
      t.boolean :reminder_notification, :default => false
      t.integer :status, :default => 1
      t.string :room_name

      t.timestamps
    end
  end
end
