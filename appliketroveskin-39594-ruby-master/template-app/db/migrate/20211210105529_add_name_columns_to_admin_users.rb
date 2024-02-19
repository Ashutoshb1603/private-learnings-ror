class AddNameColumnsToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :admin_users, :name, :first_name
    add_column :admin_users, :last_name, :string
    add_column :admin_users, :gender, :string
  end
end
