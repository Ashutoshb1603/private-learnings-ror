class CreateAccountEventBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :account_event_blocks do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
