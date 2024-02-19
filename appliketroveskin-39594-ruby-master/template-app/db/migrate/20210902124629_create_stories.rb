class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.references :objectable, polymorphic: true
      t.integer :target

      t.timestamps
    end
  end
end
