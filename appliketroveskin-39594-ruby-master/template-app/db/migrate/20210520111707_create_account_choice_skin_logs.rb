class CreateAccountChoiceSkinLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :account_choice_skin_logs do |t|
      t.references :account, null: false, foreign_key: true
      t.references :skin_quiz, null: false, foreign_key: true
      t.bigint :choice_ids, array: true
      t.string :other

      t.timestamps
    end
  end
end
