class AddDeviceTokenToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :device_token, :string
    add_column :admin_users, :device, :string
    add_column :admin_users, :sign_in_count, :integer, :default => 0
  end
end
