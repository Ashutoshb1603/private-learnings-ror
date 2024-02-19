class CreateConsultationAddonPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :consultation_addon_prices do |t|
      t.decimal :addon_price, precision: 10, scale: 2, default: 0.0
      t.integer :weeks

      t.timestamps
    end
  end
end
