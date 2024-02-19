class CreateInfoTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :info_texts do |t|
      t.string :description, :default => ""
      t.integer :screen

      t.timestamps
    end
  end
end
