class AddColumnToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :product_image_url, :string
    add_column :shopping_cart_orders, :shipping_id, :integer
  end
end
