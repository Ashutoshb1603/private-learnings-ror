class AddInfoTextToSkinQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_quizzes, :info_text, :string, :default => ""
  end
end
