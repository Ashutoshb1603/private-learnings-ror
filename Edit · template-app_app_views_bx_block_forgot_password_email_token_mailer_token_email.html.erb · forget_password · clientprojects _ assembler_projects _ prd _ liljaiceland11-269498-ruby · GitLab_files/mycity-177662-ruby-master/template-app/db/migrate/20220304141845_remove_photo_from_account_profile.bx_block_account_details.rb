# This migration comes from bx_block_account_details (originally 20210118104121)
class RemovePhotoFromAccountProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :account_profiles, :photo, :string
  end
end
