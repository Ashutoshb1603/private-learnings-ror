# This migration comes from bx_block_company (originally 20210224113144)
class AddCeoToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :email, :string
    add_column :companies, :ceo_of_company, :string
  end
end
