class AddColumnsToWalletTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :wallet_transactions, :sender_id, :integer
    add_column :wallet_transactions, :receiver_id, :integer
    add_column :wallet_transactions, :reference_id, :string
  end
end
