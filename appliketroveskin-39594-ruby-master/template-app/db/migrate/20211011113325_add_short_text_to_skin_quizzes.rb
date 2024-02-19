class AddShortTextToSkinQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_quizzes, :short_text, :string, :default => ""
  end
end
