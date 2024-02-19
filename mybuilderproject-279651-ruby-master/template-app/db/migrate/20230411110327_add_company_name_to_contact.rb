class AddCompanyNameToContact < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :company_name, :string
    rename_column :contacts, :name, :first_name
    add_column :contacts, :last_name, :string
  end
end
