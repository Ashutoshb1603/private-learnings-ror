# This migration comes from bx_block_company (originally 20201211115934)
class AddFieldsToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :industry, :string
    add_column :companies, :company_type, :string
    add_column :companies, :headquarters, :string
    add_column :companies, :established_in, :datetime
    add_column :companies, :no_of_employees, :integer
    add_column :companies, :type_of_company, :string
    add_column :companies, :tagline, :string
    add_column :companies, :public_link, :string
    add_column :companies, :about_the_company, :text
  end
end
