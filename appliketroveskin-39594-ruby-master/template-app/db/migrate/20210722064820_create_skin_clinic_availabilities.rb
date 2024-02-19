class CreateSkinClinicAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_clinic_availabilities do |t|
      t.references :skin_clinic, null: false, foreign_key: true
      t.string :day
      t.time :from
      t.time :to

      t.timestamps
    end
  end
end
