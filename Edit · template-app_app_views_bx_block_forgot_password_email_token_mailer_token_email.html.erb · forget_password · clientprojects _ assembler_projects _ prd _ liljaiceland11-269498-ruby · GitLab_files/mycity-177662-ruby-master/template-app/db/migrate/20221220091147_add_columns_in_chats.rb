class AddColumnsInChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :conversation_sid, :string
    add_column :chats, :group_image, :string
  end
end
