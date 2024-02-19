# This migration comes from bx_block_events (originally 20210410060645)
class AddAddressToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :address, :text
  end
end
