class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :plan_id
      t.integer :account_id
      t.integer :status
      t.string :token
      t.string :charge_id
      t.string :error_message
      t.string :customer_id
      t.integer :payment_gateway
      t.integer :price_cents

      t.timestamps
    end
  end
end
