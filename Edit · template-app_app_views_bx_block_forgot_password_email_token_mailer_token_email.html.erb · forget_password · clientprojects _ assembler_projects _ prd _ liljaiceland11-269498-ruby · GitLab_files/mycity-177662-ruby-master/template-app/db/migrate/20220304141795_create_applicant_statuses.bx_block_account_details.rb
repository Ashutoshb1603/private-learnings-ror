# This migration comes from bx_block_account_details (originally 20201218115109)
class CreateApplicantStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :applicant_statuses do |t|
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
