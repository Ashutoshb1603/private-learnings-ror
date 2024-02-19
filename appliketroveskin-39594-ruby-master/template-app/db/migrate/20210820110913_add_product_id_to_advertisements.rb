class AddProductIdToAdvertisements < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :product_id, :string
    add_column :advertisements, :country, :string, :default => "Ireland"
  end
end
