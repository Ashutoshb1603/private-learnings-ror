class CreateSkinQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_quizzes do |t|
      t.text :question

      t.timestamps
    end
  end
end
