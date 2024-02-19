class AddAcuityFieldIdToSkinQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_quizzes, :acuity_field_id, :string, :default => ""
  end
end
