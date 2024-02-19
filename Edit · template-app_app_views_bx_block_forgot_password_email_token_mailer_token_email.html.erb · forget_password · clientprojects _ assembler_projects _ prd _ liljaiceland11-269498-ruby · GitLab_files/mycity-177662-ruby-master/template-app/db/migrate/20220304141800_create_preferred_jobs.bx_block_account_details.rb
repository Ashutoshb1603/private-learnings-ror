# This migration comes from bx_block_account_details (originally 20201117031358)
class CreatePreferredJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :preferred_jobs do |t|
      t.references :account, null: false, foreign_key: true
      t.string :job_name
      t.string :skills
      t.string :location
      t.string :job_type
      t.string :notice_perdiod
      t.string :visa_type
      t.boolean :is_foreign_visa_available
      t.string :resume

      t.timestamps
    end
  end
end
