# This migration comes from bx_block_account_details (originally 20201117030124)
class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.string :company_name
      t.string :location
      t.string :position
      t.string :job_type
      t.date :joining_date
      t.date :leaving_date
      t.string :bio
      t.boolean :currently_working
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
