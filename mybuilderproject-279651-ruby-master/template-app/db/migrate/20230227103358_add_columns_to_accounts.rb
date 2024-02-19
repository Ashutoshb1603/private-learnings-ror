class AddColumnsToAccounts < ActiveRecord::Migration[6.0]
  def change
	  rename_column :accounts, :first_name, :operator_name
	  rename_column :accounts, :last_name, :contact_name
	  add_column :accounts, :operator_address, :string
  end
end
