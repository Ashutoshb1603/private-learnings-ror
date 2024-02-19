# This migration comes from bx_block_account_details (originally 20210224123533)
class AddRateToPreferredJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :preferred_jobs, :rate_per_hour, :integer
    add_column :preferred_jobs, :available_as_freelancer, :boolean
  end
end
