class AddCurrencyToWalletTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :wallet_transactions, :currency, :integer, default: 1
  end
end
