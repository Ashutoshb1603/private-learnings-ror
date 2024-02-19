class AddQuestionTypeToSkinQuiz < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_quizzes, :question_type, :string, default: 'sign_up'
    add_column :skin_quizzes, :allows_multiple, :boolean, default: false
  end
end
