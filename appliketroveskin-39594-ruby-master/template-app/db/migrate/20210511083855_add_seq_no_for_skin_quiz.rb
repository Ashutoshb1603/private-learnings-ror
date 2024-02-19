class AddSeqNoForSkinQuiz < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_quizzes, :seq_no, :integer
    add_column :skin_quizzes, :active, :boolean, default: true
    add_column :choices, :active, :boolean, default: true
  end
end
