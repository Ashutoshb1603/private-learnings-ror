class CreateEquipments < ActiveRecord::Migration[6.0]
  def change
    create_table :equipments do |t|
      t.string :name, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
