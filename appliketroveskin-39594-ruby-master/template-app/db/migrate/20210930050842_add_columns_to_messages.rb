class AddColumnsToMessages < ActiveRecord::Migration[6.0]
  def change
    remove_reference :messages, :objectable
  end
end
