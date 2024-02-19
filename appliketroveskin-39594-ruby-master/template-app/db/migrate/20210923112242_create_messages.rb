class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :chat_id
      t.integer :account_id
      t.text :message
      t.boolean :is_read, :default => false
      t.references :objectable, polymorphic: true

      t.timestamps
    end
  end
end
