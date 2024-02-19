# This migration comes from bx_block_account_details (originally 20210119070507)
class AddDateToCertification < ActiveRecord::Migration[6.0]
  def change
    add_column :certifications, :date, :date
  end
end
