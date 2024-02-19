class AddColumnsToLiveVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :live_videos, :room_sid, :string
    add_column :live_videos, :composition_sid, :string
  end
end
