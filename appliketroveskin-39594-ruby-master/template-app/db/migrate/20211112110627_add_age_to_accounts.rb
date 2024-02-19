class AddAgeToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :age, :integer
  end
end
