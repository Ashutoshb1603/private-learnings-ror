class CreateTutorialLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :tutorial_likes do |t|
      t.integer :account_id
      t.integer :tutorial_id

      t.timestamps
    end
  end
end
