class CreateRecommendedProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :recommended_products do |t|
      t.integer :therapist_id
      t.integer :account_id
      t.string :product_id

      t.timestamps
    end
  end
end
