class CreateDiscountCodeUsages < ActiveRecord::Migration[6.0]
  def change
    create_table :discount_code_usages do |t|
      t.string :discount_code
      t.integer :value_type, :default => 1
      t.integer :amount
      t.integer :account_id
      t.integer :order_id

      t.timestamps
    end
  end
end
