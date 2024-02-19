class RenameAccountColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :activities, :account_id, :accountable_id
    rename_column :comments, :account_id, :accountable_id
    rename_column :likes, :account_id, :accountable_id
    rename_column :questions, :account_id, :accountable_id
    rename_column :saved, :account_id, :accountable_id
    rename_column :views, :account_id, :accountable_id
  end
end
