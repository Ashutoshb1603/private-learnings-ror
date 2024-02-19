class AddPaypalCustomerIdToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :paypal_customer_id, :string
  end
end
