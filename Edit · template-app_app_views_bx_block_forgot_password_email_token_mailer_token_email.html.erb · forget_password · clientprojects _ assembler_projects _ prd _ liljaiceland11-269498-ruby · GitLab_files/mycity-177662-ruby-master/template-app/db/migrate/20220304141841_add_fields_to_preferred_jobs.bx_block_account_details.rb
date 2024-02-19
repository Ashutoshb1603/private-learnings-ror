# This migration comes from bx_block_account_details (originally 20201221062655)
class AddFieldsToPreferredJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :preferred_jobs, :latitude, :float
    add_column :preferred_jobs, :longitude, :float
  end
end
