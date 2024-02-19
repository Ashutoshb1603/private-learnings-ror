class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :account_id
      t.references :objectable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
