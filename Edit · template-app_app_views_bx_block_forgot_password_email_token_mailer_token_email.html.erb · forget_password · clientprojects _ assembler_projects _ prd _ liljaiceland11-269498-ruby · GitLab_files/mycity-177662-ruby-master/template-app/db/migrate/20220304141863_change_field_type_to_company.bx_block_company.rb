# This migration comes from bx_block_company (originally 20210129091852)
class ChangeFieldTypeToCompany < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :established_in, :datetime
    add_column :companies, :established_in, :string
  end
end
