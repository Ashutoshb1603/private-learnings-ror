class AddParentIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :parent_id, :string
  end
end
