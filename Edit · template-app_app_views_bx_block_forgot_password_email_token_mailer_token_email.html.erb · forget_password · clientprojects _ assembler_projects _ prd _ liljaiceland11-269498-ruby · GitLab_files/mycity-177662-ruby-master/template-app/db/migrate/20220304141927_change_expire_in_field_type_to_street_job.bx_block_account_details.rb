# This migration comes from bx_block_account_details (originally 20201208070950)
class ChangeExpireInFieldTypeToStreetJob < ActiveRecord::Migration[6.0]
  def change
    remove_column :street_jobs, :expires_in, :string
    add_column :street_jobs, :expires_in, :integer
  end
end
