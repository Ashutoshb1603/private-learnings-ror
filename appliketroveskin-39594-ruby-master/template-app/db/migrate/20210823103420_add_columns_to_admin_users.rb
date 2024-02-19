class AddColumnsToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :name, :string
    add_column :admin_users, :jwt_token, :string
  end
end
