class AddRecommendedToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :recommended, :boolean, default: false
  end
end
