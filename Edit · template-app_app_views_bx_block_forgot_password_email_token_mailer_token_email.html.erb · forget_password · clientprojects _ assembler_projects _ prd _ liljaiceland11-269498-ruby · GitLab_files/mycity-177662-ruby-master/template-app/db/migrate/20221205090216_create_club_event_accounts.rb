class CreateClubEventAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :club_event_accounts do |t|
      t.references :account, null: false, foreign_key: true
      t.references :club_event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
