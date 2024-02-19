class AddTitleInAdvertisements < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :title, :string, null: false, default: ''
  end
end
