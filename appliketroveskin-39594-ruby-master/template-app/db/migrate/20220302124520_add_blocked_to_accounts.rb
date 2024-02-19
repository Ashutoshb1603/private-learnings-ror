class AddBlockedToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :blocked, :boolean, default: false
    add_column :admin_users, :blocked, :boolean, default: false
  end
end
