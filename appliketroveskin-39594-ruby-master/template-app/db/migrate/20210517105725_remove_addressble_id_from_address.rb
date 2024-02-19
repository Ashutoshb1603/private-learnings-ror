class RemoveAddressbleIdFromAddress < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :addressble_id, :integer
    remove_column :addresses, :addressble_type, :string

    add_reference :addresses, :addressable, null: false, polymorphic: true
  end
end
