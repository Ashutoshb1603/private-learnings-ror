class CreateAccountBlockAccountsInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts_interests do |t|
      t.integer :account_id
      t.integer :interest_id

      t.timestamps
    end
  end
end
