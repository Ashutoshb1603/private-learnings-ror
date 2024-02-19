class CreateSearchHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :search_histories do |t|
      t.references :account, null: false
      t.string :content

      t.timestamps
    end

    add_index :search_histories, :content
  end
end
