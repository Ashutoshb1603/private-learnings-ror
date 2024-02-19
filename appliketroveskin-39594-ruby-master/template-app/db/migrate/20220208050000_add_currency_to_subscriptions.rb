class AddCurrencyToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :currency, :integer, default: 1
  end
end
