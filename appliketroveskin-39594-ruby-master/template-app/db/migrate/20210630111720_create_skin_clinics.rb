class CreateSkinClinics < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_clinics do |t|
      t.string :name
      t.string :location
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
