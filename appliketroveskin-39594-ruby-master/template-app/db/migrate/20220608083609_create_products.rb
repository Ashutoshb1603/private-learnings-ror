class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :product_keys do |t|
      t.string :location
      t.datetime :last_refreshed
    end
  end
end
