# This migration comes from bx_block_account_details (originally 20201222053026)
class CreateEndorses < ActiveRecord::Migration[6.0]
  def change
    create_table :endorses do |t|
      t.string :endorse_type
      t.string :name
      t.references :account, null: false, foreign_key: true
      t.references :company_culture, null: false, foreign_key: true
      t.timestamps
    end
  end
end
