class RenameColumnToAccount < ActiveRecord::Migration[6.0]
  def change
  	rename_column :accounts, :operator_name, :first_name
	rename_column :accounts, :contact_name, :last_name
  end
end
