class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.string :name
      t.integer :account_id
      t.integer :status, :default => 1
      t.datetime :start_date
      t.datetime :end_date
      t.string :chat_room_id

      t.timestamps
    end
  end
end
