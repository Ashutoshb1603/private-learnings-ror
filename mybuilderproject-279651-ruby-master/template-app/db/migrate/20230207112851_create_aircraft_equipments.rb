class CreateAircraftEquipments < ActiveRecord::Migration[6.0]
  def change
    create_table :aircraft_equipments do |t|
      t.bigint :aircraft_id
      t.boolean :v110
      t.boolean :v230
      t.boolean :headsets
      t.boolean :tv
      t.boolean :cd_dvd
      t.boolean :wifi
      t.boolean :sat_phone
      t.boolean :sat_tv
      t.boolean :entertainment_system
      t.boolean :lavatory
      t.boolean :enclosed_lavatory
      t.boolean :coffee_pot
      t.boolean :espresso
      t.boolean :ice_bin
      t.boolean :microwave_oven
      t.boolean :warming_oven
      t.boolean :smoking_allowed
      t.boolean :pets_allowed
      t.boolean :baggage_volume
      t.boolean :ski_tube
      t.boolean :golf_bags
      t.integer :standard_suitcases
      t.float :max_weight

      t.timestamps
    end
  end
end
