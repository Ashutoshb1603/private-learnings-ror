class CreateAcademyVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :academy_videos do |t|
      t.string :title
      t.text :description
      t.string :url
      t.integer :academy_id

      t.timestamps
    end
  end
end
