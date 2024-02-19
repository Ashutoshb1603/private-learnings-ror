# This migration comes from bx_block_account_details (originally 20210209113537)
class AddCompanyNameToAccountProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :account_profiles, :company_name, :string
  end
end
