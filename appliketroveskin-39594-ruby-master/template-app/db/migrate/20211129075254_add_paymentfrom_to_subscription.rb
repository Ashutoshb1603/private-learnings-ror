class AddPaymentfromToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :payment_from, :string
  end
end
