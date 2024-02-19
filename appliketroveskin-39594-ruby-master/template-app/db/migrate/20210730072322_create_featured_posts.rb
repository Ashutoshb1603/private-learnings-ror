class CreateFeaturedPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :featured_posts do |t|
      t.string :post_id

      t.timestamps
    end
  end
end
