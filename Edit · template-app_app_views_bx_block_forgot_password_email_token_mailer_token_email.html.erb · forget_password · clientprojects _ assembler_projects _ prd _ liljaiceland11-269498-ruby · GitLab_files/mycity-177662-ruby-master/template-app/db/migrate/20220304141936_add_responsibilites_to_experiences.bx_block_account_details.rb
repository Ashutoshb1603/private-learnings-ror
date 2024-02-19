# This migration comes from bx_block_account_details (originally 20210119071231)
class AddResponsibilitesToExperiences < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :responsibilities, :text
  end
end
