class AddOffensiveFlagToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :offensive, :boolean, :default => false
  end
end
