class RemoveNullFalseFromNotifications < ActiveRecord::Migration[6.0]
  def up
    change_column :notifications, :account_id, :bigint, null: true
  end

  def down
    change_column :notifications, :account_id, :bigint
  end
end
