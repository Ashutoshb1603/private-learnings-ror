class AddRefundedMoneyToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :refunded_amount, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end
end
