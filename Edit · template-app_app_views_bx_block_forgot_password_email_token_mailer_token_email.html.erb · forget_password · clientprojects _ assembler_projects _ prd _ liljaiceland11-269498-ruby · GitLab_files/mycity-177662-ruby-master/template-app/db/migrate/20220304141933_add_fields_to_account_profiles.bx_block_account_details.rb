# This migration comes from bx_block_account_details (originally 20210119064338)
class AddFieldsToAccountProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :account_profiles, :email, :string
    add_column :account_profiles, :profile_summary, :text
  end
end
