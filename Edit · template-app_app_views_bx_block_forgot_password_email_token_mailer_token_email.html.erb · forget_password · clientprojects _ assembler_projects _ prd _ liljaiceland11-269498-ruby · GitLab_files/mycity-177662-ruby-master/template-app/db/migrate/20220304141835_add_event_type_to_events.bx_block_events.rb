# This migration comes from bx_block_events (originally 20210222090433)
class AddEventTypeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :event_type, :string
  end
end
