class AddTypeToNotifications < ActiveRecord::Migration[6.0]
  def change
    if !BxBlockNotifications::Notification.column_names.include?('type')
      add_column :notifications, :type , :string
    end
  end
end
