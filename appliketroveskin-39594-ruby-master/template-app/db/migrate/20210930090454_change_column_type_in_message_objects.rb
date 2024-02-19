class ChangeColumnTypeInMessageObjects < ActiveRecord::Migration[6.0]
  def change
    change_column :message_objects, :object_id, :string
    change_column :message_objects, :variant_id, :string
    remove_column :message_objects, :product_id, :string
  end
end
