class CreateAdvertisements < ActiveRecord::Migration[6.0]
  def change
    create_table :advertisements do |t|
      t.string :url
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
