class AddLocationInAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :latitude, :float
    add_column :accounts, :longitude, :float
    add_column :accounts, :current_city, :string
  end
end
