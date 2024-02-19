class AddColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :total_tax, :decimal
    add_column :shopping_cart_orders, :shipping_charges, :decimal
    add_column :shopping_cart_orders, :tax_title, :string
    add_column :shopping_cart_orders, :shipping_title, :string
  end
end
