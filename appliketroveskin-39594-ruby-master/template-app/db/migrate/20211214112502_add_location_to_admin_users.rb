class AddLocationToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :location, :string, :default => 'Ireland'
  end
end
