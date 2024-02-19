class CreateProductVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :product_videos do |t|
      t.string :product_id
      t.string :video_url

      t.timestamps
    end
  end
end
