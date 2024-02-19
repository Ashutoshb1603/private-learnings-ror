class CreateViews < ActiveRecord::Migration[6.0]
  def change
    create_table :views do |t|
      t.integer :account_id
      t.integer :question_id

      t.timestamps
    end
  end
end
