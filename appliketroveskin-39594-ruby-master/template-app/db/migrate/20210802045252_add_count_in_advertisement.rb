class AddCountInAdvertisement < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :click_count, :integer, default: 0
  end
end
