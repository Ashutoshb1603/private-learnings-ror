# This migration comes from bx_block_stripe_integration (originally 20201113114256)
class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.string :card_token
      t.boolean :is_primary, :default => false
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
