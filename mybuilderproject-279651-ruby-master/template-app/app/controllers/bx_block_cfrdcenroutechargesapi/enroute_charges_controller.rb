module BxBlockCfrdcenroutechargesapi
  class EnrouteChargesController < ApplicationController
    def create_enroute_charge
      enroute_data = BxBlockCfrdcenroutechargesapi::RdcEnrouteChargeApiService.create_rdc_enroute_charge_data
      render json: {message: "data is storing in Database.", data: enroute_data}, status: :ok
    end
  end
end
