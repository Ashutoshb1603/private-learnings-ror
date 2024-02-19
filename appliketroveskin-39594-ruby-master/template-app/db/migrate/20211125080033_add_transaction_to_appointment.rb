class AddTransactionToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :transaction_id, :string
  end
end
