module BxBlockCfrdcenroutechargesapi
    class EnrouteCharge < BxBlockCfrdcenroutechargesapi::ApplicationRecord
        self.table_name = :enroute_charges
        store_accessor :enroute_charge_data, :enrouteCountryCharges
    end
end