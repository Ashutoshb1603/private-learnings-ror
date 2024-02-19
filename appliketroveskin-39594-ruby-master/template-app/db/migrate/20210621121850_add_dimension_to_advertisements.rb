class AddDimensionToAdvertisements < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :dimension, :string
  end
end
