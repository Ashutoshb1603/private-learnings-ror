class AddFieldsToWalletTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :wallet_transactions, :custom_message, :string
    add_column :wallet_transactions, :gift_type_id, :integer
  end
end
