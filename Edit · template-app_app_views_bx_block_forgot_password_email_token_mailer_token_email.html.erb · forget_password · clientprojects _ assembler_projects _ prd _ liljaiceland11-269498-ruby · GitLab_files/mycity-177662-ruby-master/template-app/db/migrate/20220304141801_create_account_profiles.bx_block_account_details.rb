# This migration comes from bx_block_account_details (originally 20201117030422)
class CreateAccountProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :account_profiles do |t|
      t.string :name
      t.string :profession
      t.references :company, null: false, foreign_key: true
      t.string :gender
      t.string :full_address
      t.string :bio
      t.references :account, null: false, foreign_key: true
      t.string :photo

      t.timestamps
    end
  end
end
