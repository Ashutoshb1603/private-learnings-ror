class AddColumnToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :next_payment_date, :date
  end
end
