# This migration comes from bx_block_account_details (originally 20201204090852)
class CreateStreetJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :street_jobs do |t|
      t.string :company_name
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :type_of_employer
      t.string :role
      t.string :job_type
      t.string :salary_range
      t.text :job_description
      t.string :expires_in
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
