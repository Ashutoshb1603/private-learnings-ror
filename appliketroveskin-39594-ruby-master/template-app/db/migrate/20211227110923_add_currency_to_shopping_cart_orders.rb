class AddCurrencyToShoppingCartOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :currency, :integer, :default => 1
  end
end
