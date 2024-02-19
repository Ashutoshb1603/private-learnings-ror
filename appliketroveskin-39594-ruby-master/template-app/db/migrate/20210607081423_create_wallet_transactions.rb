class CreateWalletTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :wallet_transactions do |t|
      t.integer :wallet_id
      t.integer :transaction_type
      t.decimal :amount
      t.integer :status
      t.string :comment, :default => ""

      t.timestamps
    end
  end
end
