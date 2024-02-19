class AddDeviceTokenToAccounts < ActiveRecord::Migration[6.0]
  def up
    add_column :accounts, :device_token, :text
    change_table :notifications do |t|
      t.change :contents, :text
    end
  end

  def down
    remove_column :accounts, :device_token, :text
    change_table :notifications do |t|
      t.change :contents, :string
    end
  end
end
