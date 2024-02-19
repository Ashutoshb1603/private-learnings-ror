class ChangeCurrencyTypeInWallets < ActiveRecord::Migration[6.0]
  def change
    remove_column :wallets, :currency, :string
    add_column :wallets, :currency, :integer, :default => 1
  end
end
