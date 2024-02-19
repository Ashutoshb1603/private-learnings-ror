# This migration comes from bx_block_account_details (originally 20201117030251)
class CreateSkillSets < ActiveRecord::Migration[6.0]
  def change
    create_table :skill_sets do |t|
      t.string :name
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
