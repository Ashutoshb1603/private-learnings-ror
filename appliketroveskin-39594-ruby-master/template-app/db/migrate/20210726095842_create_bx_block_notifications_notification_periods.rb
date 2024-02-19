class CreateBxBlockNotificationsNotificationPeriods < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_periods do |t|
      t.string :notification_type
      t.string :period_type
      t.integer :period

      t.timestamps
    end
  end
end
