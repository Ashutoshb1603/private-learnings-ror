# This migration comes from bx_block_account_details (originally 20201231070157)
class CreateTransferRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :transfer_requests do |t|
      t.integer :status, default: 0, null: false
      t.float :amount
      t.references :wallet, null: false, foreign_key: true
      t.timestamps
    end
  end
end
