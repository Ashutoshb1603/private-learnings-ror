# This migration comes from bx_block_account_details (originally 20201218051729)
class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.references :account, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end
