# This migration comes from bx_block_account_details (originally 20210127061946)
class CreateFollowships < ActiveRecord::Migration[6.0]
  def change
    create_table :followships do |t|
      t.references :account, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end
