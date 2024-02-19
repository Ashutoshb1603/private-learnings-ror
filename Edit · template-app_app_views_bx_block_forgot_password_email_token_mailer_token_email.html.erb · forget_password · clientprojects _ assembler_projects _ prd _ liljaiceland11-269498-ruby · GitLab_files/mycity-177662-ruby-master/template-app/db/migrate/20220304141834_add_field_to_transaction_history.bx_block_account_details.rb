# This migration comes from bx_block_account_details (originally 20201202104219)
class AddFieldToTransactionHistory < ActiveRecord::Migration[6.0]
  def change
    add_column :transaction_histories, :transaction_type, :string
    rename_column :transaction_histories, :my_wallet_id, :wallet_id
  end
end
