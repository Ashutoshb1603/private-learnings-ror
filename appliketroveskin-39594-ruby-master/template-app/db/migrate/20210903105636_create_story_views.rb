class CreateStoryViews < ActiveRecord::Migration[6.0]
  def change
    create_table :story_views do |t|
      t.integer :account_id
      t.integer :story_id

      t.timestamps
    end
  end
end
