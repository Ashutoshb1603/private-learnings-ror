require 'rails_helper'

RSpec.describe "BxBlockCfrdcenroutechargesapi::EnrouteCharge", type: :request do
  describe "store enroute charge data in db" do
    it "create and save data" do
      post "/bx_block_cfrdcenroutechargesapi/enroute_charges/create_enroute_charge", headers: {}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
  end
end
