class AddPaymentIdToCustomerAcademySubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_academy_subscriptions, :payment_id, :string, :default => ""
  end
end
