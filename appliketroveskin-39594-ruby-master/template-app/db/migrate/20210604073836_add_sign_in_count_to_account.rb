class AddSignInCountToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :sign_in_count, :integer, default: 0
  end
end
