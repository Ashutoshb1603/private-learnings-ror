# This migration comes from bx_block_account_details (originally 20210209113206)
class RemoveCompanyFromAccountProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :account_profiles, :company_id, :integer
  end
end
