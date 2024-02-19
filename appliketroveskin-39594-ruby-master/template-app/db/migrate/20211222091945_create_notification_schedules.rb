class CreateNotificationSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_schedules do |t|
      t.string :title
      t.string :message
      t.datetime :at

      t.timestamps
    end
  end
end
