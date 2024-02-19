class AddSidToChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :sid, :string
  end
end
