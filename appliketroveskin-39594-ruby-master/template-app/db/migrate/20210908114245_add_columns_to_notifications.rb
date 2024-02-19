class AddColumnsToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :room_name, :string
    add_column :notifications, :notification_type, :integer, :default => 1
  end
end
