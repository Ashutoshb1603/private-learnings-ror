class CreateCustomerAcademySubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_academy_subscriptions do |t|
      t.integer :account_id
      t.integer :academy_id

      t.timestamps
    end
  end
end
