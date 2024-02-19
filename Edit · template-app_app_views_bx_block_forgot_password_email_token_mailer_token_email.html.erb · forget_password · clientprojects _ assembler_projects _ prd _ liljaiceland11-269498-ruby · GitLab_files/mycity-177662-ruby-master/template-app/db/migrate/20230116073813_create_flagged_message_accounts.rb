class CreateFlaggedMessageAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :flagged_message_accounts do |t|
      t.references :account
      t.references :flagged_message

      t.timestamps
    end
  end
end
