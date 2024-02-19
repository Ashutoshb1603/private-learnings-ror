class AddAddonPriceInPoundsToConsultationAddonPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :consultation_addon_prices, :addon_price_in_pounds, :decimal, precision: 10, scale: 2
  end
end
