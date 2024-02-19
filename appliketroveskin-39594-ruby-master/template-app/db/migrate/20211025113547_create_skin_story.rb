class CreateSkinStory < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_stories do |t|
      t.string :client_name
      t.string :age
      t.references :concern, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
