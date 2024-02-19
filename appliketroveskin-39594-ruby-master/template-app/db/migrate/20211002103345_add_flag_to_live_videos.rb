class AddFlagToLiveVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :live_videos, :status, :integer, :default => 2
  end
end
