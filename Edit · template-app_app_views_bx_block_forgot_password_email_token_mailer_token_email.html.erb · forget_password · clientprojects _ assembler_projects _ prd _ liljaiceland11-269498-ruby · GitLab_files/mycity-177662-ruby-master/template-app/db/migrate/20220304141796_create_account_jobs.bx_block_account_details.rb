# This migration comes from bx_block_account_details (originally 20201207093644)
class CreateAccountJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :account_jobs do |t|
      t.string :type
      t.integer :account_id
      t.integer :job_id
      t.string :job_type
      t.timestamps
    end
  end
end
