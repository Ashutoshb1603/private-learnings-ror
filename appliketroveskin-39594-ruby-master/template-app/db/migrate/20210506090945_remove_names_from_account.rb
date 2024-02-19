class RemoveNamesFromAccount < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :first_name, :string
    remove_column :accounts, :last_name, :string
    remove_column :accounts, :user_name, :string

    add_column :accounts, :name, :string
  end
end
