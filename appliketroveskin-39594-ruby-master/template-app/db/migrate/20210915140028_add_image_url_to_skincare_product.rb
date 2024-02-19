class AddImageUrlToSkincareProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :skincare_products, :image_url, :text
  end
end
