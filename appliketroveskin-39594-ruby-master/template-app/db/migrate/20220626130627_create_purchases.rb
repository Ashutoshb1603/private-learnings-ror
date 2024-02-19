class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.integer :recommended_product_id
      t.integer :quantity
      t.timestamps
    end
  end
end
