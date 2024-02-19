class CreateDynamicImages < ActiveRecord::Migration[6.0]
  def change
    create_table :dynamic_images do |t|
      t.integer :image_type

      t.timestamps
    end
  end
end
