class AddUserTypeToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :user_type, :integer, :default => 1
  end
end
