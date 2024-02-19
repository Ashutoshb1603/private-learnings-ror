class AddDeviceToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :device, :string
  end
end
