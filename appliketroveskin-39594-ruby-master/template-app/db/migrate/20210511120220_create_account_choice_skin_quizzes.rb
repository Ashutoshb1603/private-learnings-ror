class CreateAccountChoiceSkinQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :account_choice_skin_quizzes do |t|
      t.references :skin_quiz, null: false, foreign_key: true, index: {name: 'index_skin_quiz_on_skin_quiz_user_choice'}
      t.references :account, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
