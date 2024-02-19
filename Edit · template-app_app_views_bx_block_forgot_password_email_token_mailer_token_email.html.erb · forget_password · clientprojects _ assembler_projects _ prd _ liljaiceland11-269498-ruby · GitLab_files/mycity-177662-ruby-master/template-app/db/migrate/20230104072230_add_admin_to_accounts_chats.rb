class AddAdminToAccountsChats < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts_chats, :is_admin, :boolean, default: false
    add_column :accounts_chats, :participant_sid, :string
  end
end
