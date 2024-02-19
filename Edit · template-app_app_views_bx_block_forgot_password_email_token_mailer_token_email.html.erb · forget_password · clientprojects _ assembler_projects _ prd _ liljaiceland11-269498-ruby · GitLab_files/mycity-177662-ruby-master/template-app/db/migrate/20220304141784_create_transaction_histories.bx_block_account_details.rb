# This migration comes from bx_block_account_details (originally 20201202073932)
class CreateTransactionHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_histories do |t|
      t.references :my_wallet, null: false, foreign_key: true
      t.string :transaction_entity_type
      t.string :transaction_entity_name
      t.float :amount
      t.string :transaction_id
      t.timestamps
    end
  end
end
