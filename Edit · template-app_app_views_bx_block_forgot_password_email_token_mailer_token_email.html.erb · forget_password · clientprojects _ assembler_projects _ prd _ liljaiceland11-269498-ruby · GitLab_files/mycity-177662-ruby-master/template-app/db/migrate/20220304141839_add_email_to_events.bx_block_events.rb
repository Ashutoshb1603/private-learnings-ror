# This migration comes from bx_block_events (originally 20210608083349)
class AddEmailToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :assignee_email, :string, array: true, default: []
    add_column :events, :visible_email, :string, array: true, default: []
  end
end
