class AddRequiresShippingToShoppingCartOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :requires_shipping, :boolean, :default => true
  end
end
