class CreateConsultationPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :consultation_prices do |t|
      t.integer :currency, default: 1
      t.decimal :price, precision: 10, scale: 2
      t.string :consultation_id

      t.timestamps
    end
  end
end
