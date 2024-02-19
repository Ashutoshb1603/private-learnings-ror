class AddColumnsInChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :therapist_id, :integer
    add_column :chats, :pinned, :boolean, :default => false
    remove_column :chats, :name, :string
    remove_column :chats, :chat_room_id, :string
  end
end
