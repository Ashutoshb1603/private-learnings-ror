# This migration comes from bx_block_stripe_integration (originally 20201118032226)
class Payments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :ammount
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
