class CreateQuestionTags < ActiveRecord::Migration[6.0]
  def change
    create_table :question_tags do |t|
      t.integer :group_id
      t.integer :question_id

      t.timestamps
    end
  end
end
