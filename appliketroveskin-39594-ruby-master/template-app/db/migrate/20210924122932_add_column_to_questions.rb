class AddColumnToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :user_type, :integer, :default => 1
  end
end
