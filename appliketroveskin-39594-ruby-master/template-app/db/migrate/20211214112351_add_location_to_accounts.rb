class AddLocationToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :location, :string, :default => 'Ireland'
  end
end
