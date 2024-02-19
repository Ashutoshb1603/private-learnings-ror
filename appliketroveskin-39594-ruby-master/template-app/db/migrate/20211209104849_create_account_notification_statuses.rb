class CreateAccountNotificationStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :account_notification_statuses do |t|
      t.references :account, null: false, foreign_key: true
      t.references :notification_type, null: false, foreign_key: true
      t.boolean :enabled, :default => false, null: false

      t.timestamps
    end
  end
end
