# This migration comes from bx_block_events (originally 20210412072737)
class AddFieldToEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :custom_repeat, :string
    add_column :events, :custom_repeat_in_number, :integer
    add_column :events, :custom_repeat_every, :integer
  end
end
