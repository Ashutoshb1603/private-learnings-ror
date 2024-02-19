class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.string :variant_id
      t.integer :quantity
      t.integer :account_id
      t.string :name
      t.decimal :price
      t.string :product_id
      t.string :product_image_url
      t.decimal :total_price

      t.timestamps
    end
  end
end
