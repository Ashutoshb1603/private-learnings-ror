class AddPriceInPoundsToAcademies < ActiveRecord::Migration[6.0]
  def change
    add_column :academies, :price_in_pounds, :decimal, precision: 10, scale: 2
  end
end
