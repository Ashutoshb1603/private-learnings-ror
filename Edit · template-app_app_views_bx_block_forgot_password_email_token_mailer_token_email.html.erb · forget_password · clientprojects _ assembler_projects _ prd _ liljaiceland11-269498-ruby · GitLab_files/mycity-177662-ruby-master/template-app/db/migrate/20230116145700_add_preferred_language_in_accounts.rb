class AddPreferredLanguageInAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :preferred_language, :string
  end
end
