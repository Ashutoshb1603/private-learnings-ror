class CreateSubscription < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :frequency
      t.integer :account_id
      t.boolean :is_cancelled, default: false
      t.integer :amount

      t.timestamps
    end
  end
end
