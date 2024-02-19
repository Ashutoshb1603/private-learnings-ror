# This migration comes from bx_block_account_details (originally 20201219071557)
class CreateApplicantComments < ActiveRecord::Migration[6.0]
  def change
    create_table :applicant_comments do |t|
      t.text :comment
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
