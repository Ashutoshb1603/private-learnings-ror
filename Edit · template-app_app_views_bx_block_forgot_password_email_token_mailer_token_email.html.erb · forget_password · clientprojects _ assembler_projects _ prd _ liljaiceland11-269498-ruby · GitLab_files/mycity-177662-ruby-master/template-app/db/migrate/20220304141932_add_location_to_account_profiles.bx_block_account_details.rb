# This migration comes from bx_block_account_details (originally 20210115115457)
class AddLocationToAccountProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :account_profiles, :location, :string
    add_column :account_profiles, :latitude, :float
    add_column :account_profiles, :longitude, :float
  end
end
