# This migration comes from bx_block_account_details (originally 20201202095646)
class RenameTableMyWalletToWallet < ActiveRecord::Migration[6.0]
  def change
    remove_column :my_wallets, :available_balance, :float
    add_column :my_wallets, :available_balance, :float, default: 0.0
    rename_table :my_wallets, :wallets
  end
end
