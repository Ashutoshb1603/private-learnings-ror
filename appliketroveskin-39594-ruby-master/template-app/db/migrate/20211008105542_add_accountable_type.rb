class AddAccountableType < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :accountable_type, :string
    add_column :comments, :accountable_type, :string
    add_column :likes, :accountable_type, :string
    add_column :questions, :accountable_type, :string
    add_column :saved, :accountable_type, :string
    add_column :views, :accountable_type, :string
  end
end
