class CreateCustomerFavouriteProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_favourite_products do |t|
      t.integer :account_id
      t.string :product_id

      t.timestamps
    end
  end
end
