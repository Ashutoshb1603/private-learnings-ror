class RenameColumnsOfAddesses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :street1, :street
    rename_column :addresses, :street2, :county
  end
end
