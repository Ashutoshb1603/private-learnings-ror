class RemoveCickCountFromTables < ActiveRecord::Migration[6.0]
  def change
    remove_column :skin_clinics, :click_count, :integer
    remove_column :advertisements, :click_count, :integer
  end
end
