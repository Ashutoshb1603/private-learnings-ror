class AddIsPinnedToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :is_pinned, :boolean, default: false
  end
end
