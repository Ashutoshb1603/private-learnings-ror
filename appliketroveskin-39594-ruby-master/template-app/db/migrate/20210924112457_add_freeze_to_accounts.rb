class AddFreezeToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :freeze_account, :boolean, :default => false
  end
end
