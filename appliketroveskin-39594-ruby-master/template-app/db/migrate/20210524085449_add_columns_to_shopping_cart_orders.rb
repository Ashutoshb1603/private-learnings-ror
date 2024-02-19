class AddColumnsToShoppingCartOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :cancel_reason, :text
    add_column :shopping_cart_orders, :cancelled_at, :date
    add_column :shopping_cart_orders, :subtotal_price, :decimal, precision: 10, scale: 2
    add_column :shopping_cart_orders, :total_price, :decimal, precision: 10, scale: 2
  end
end
