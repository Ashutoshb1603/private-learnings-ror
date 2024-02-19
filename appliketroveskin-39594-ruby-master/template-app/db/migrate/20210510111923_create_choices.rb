class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.text :choice
      t.integer :skin_quiz_id

      t.timestamps
    end
  end
end
