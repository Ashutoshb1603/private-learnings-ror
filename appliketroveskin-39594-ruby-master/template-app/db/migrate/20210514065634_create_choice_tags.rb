class CreateChoiceTags < ActiveRecord::Migration[6.0]
  def change
    create_table :choice_tags do |t|
      t.references :choice, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
