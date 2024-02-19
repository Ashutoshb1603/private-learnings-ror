class AddFieldsToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :leon_access_token, :string
    add_column :accounts, :leon_refresh_token, :string
    add_column :accounts, :leon_client_id, :string
    add_column :accounts, :leon_client_sceret, :string
    add_column :accounts, :leon_expire_time, :datetime
  end
end
