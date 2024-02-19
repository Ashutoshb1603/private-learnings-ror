# This migration comes from bx_block_company (originally 20210119041327)
class AddApprovedToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :approved, :boolean, default: false
  end
end
