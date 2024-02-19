# This migration comes from bx_block_account_details (originally 20210201061136)
class CreateCompanyUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :company_users do |t|
      t.string :role
      t.references :company, index: true
      t.references :account, index: true
      t.timestamps
    end
  end
end
