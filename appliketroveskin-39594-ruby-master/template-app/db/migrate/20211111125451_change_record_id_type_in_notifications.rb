class ChangeRecordIdTypeInNotifications < ActiveRecord::Migration[6.0]
  def change
    change_column :notifications, :record_id, :string
  end
end
