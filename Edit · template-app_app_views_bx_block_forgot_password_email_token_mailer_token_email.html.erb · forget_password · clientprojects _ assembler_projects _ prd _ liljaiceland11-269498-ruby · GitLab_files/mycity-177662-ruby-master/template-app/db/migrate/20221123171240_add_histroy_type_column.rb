class AddHistroyTypeColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :search_histories, :history_type, :string
  end
end
