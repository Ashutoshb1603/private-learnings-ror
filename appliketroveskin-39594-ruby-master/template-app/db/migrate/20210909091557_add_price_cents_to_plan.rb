class AddPriceCentsToPlan < ActiveRecord::Migration[6.0]
  def change
    change_column :plans, :price_cents, :decimal
  end
end
