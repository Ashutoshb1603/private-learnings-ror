class AddAccountableToNotifications < ActiveRecord::Migration[6.0]
  def change
    rename_column :notifications, :account_id, :accountable_id
    add_column :notifications, :accountable_type, :string
  end
end
