class CreateRecentSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :recent_searches do |t|
      t.string :search_param
      t.integer :account_id

      t.timestamps
    end
  end
end
