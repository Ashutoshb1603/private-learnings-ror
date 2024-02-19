# This migration comes from bx_block_events (originally 20210406125151)
class AddCustomRepeatToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :custom_repeat, :string
  end
end
