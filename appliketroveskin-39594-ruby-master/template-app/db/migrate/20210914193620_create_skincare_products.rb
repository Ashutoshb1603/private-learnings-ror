class CreateSkincareProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :skincare_products do |t|
      t.string :name
      t.string :product_id
      t.integer :skincare_routine_id

      t.timestamps
    end
  end
end
