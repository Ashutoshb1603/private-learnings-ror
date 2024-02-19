class AddAddedInWalletToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :added_in_wallet, :boolean, :default => false
  end
end
