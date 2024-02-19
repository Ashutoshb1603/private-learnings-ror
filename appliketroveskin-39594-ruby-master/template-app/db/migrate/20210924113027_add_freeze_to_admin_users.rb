class AddFreezeToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :freeze_account, :boolean, :default => false
  end
end
