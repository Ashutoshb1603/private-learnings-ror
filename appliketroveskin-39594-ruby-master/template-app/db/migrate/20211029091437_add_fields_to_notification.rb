class AddFieldsToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :record_id, :integer, null: true
    add_column :notifications, :notification_for, :string, null: true
  end
end
