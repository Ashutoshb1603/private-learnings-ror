class AddLastNameToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :last_name, :string
    rename_column :accounts, :name, :first_name
  end
end
