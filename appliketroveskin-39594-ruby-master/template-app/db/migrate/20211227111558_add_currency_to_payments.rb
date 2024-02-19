class AddCurrencyToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :currency, :integer, :default => 1
  end
end
