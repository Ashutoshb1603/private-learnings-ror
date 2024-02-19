class CreateFlaggedMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :flagged_messages do |t|
      t.string :conversation_sid
      t.string :message_sid
      t.integer :flag_count, default: 0

      t.timestamps
    end
  end
end
