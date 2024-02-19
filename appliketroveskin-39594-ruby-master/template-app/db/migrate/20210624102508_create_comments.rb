class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.references :objectable, polymorphic: true
      t.integer :account_id

      t.timestamps
    end
  end
end
