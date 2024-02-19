class AddUniqueCodeToClubEventAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :club_event_accounts, :unique_code, :integer
  end
end
