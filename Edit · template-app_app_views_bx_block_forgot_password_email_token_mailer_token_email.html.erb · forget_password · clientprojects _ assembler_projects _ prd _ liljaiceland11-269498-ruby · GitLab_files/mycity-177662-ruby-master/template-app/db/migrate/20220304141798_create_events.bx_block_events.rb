# This migration comes from bx_block_events (originally 20210209060507)
class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.time :time
      t.date :date
      t.string :latitude
      t.string :longitude
      t.string :assign_to, array: true, default: []
      t.bigint :email_account_id
      t.integer :notify
      t.integer :repeat
      t.text :notes
      t.string :visibility, array: true, default: []
      t.timestamps
    end
  end
end
