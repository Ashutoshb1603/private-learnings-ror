class AddColumnToActivity < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :status, :integer, default: 0
  end
end
