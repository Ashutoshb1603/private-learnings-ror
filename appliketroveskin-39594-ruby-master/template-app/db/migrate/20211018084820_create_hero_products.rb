class CreateHeroProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :hero_products do |t|
      t.integer :tags_type, :default => 1
      t.string :title, :default => ""
      t.text :tags, :default => ""

      t.timestamps
    end
  end
end
