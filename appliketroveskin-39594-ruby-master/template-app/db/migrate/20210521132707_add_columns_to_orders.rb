class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :email, :string
    add_column :shopping_cart_orders, :phone, :string
    add_column :shopping_cart_orders, :financial_status, :integer, :default => 1
    add_column :shopping_cart_orders, :order_id, :string
  end
end
