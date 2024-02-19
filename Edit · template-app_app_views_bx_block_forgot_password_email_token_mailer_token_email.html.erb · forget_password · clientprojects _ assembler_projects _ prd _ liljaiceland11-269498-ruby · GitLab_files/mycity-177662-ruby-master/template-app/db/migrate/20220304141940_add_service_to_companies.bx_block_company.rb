# This migration comes from bx_block_company (originally 20201215104141)
class AddServiceToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :services, :string, array: true, default: []
  end
end
