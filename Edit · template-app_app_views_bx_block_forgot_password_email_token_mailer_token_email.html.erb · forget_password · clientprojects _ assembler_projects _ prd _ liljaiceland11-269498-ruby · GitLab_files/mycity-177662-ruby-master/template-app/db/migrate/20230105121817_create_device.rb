class CreateDevice < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :token
      t.string :platform
      t.references :account, null: true, foreign_key: true

      t.timestamps
    end
  end
end
