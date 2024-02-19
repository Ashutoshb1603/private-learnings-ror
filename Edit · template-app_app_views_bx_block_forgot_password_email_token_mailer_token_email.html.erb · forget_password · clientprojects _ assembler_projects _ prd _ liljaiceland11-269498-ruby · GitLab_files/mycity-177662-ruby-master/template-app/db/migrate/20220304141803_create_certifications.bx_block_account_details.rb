# This migration comes from bx_block_account_details (originally 20201117030153)
class CreateCertifications < ActiveRecord::Migration[6.0]
  def change
    create_table :certifications do |t|
      t.string :name
      t.string :organization_name
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
