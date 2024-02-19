class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.integer :status, :default => 1
      t.integer :account_id
      t.boolean :anonymous, :default => false

      t.timestamps
    end
  end
end
