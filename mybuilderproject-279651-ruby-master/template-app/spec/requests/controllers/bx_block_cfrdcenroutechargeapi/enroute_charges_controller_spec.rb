require 'rails_helper'
RSpec.describe BxBlockCfrdcenroutechargesapi::EnrouteChargesController, type: :controller do
  describe '#create_enroute_charge' do
    it "should create enroute charge data" do
      post :create_enroute_charge
      JSON.parse(response.body)
    end
  end
end
