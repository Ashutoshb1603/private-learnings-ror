class AddColumnsToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :name, :string
    add_column :line_items, :price, :decimal, precision: 10, scale: 2
    add_column :line_items, :total_discount, :decimal, precision: 10, scale: 2
    add_column :line_items, :product_id, :string
  end
end
