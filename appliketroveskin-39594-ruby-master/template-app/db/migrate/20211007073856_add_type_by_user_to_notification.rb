class AddTypeByUserToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :type_by_user, :string
  end
end
