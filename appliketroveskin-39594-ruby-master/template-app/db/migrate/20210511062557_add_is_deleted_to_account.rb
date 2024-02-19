class AddIsDeletedToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :is_deleted, :boolean, default: false
  end
end
