class AddAccountTypeToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :account_type, :string, :default => "AccountBlock::Account"
  end
end
