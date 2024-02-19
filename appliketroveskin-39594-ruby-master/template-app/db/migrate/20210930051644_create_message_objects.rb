class CreateMessageObjects < ActiveRecord::Migration[6.0]
  def change
    create_table :message_objects do |t|
      t.integer :object_id
      t.string :object_type
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.string :product_id
      t.string :variant_id
      t.string :image_url
      t.references :message

      t.timestamps
    end
  end
end
