class CreateBlogViews < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_views do |t|
      t.string :blog_id
      t.integer :account_id

      t.timestamps
    end
  end
end
