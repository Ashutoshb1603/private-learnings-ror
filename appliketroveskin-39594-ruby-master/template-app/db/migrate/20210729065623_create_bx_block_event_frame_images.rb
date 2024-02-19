class CreateBxBlockEventFrameImages < ActiveRecord::Migration[6.0]
  def change
    create_table :frame_images do |t|
      t.string :user_type
      t.references :life_event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
