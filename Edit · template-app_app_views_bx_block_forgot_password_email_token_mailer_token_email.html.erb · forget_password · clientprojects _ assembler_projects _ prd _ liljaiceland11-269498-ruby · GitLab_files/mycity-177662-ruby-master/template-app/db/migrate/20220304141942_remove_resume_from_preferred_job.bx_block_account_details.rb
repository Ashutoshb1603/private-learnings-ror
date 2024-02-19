# This migration comes from bx_block_account_details (originally 20201119211423)
class RemoveResumeFromPreferredJob < ActiveRecord::Migration[6.0]
  def change
    remove_column :preferred_jobs, :resume, :string
    rename_column :preferred_jobs, :notice_perdiod, :notice_period
  end
end
