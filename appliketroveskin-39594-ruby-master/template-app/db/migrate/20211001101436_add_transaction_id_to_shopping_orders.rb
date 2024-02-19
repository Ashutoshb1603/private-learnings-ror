class AddTransactionIdToShoppingOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_cart_orders, :transaction_id, :string
  end
end
