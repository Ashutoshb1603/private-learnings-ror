class AddColumnShowFrameToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :user_events, :show_frame_till, :datetime
  end
end
