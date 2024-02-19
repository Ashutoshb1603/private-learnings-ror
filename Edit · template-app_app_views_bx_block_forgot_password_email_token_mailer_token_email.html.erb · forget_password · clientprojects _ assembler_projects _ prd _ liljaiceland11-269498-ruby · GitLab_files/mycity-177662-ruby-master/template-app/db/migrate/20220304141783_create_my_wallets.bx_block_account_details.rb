# This migration comes from bx_block_account_details (originally 20201202072718)
class CreateMyWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :my_wallets do |t|
      t.references :account, null: false, foreign_key: true
      t.float :available_balance
      t.timestamps
    end
  end
end
