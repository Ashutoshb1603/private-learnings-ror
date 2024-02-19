class CreateSkinTreatmentLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_treatment_locations do |t|
      t.string :location
      t.string :url

      t.timestamps
    end
  end
end
