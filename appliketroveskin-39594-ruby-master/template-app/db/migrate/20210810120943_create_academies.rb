class CreateAcademies < ActiveRecord::Migration[6.0]
  def change
    create_table :academies do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
