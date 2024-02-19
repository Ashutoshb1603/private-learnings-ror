require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::FlightsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
    
  end

  describe "Get#index" do
    flight_data_res = {
    "cost": 2,
    "success": true,
    "comment": "Successfully fetched details for 2 flights",
    "flights": [
        {
            "callsign": "VNT824",
            "flightNumberIcao": "VNT824",
            "aircraftRegistration": "N824CC",
            "aircraftModeS": "AB3FEC",
            "aircraftType": "LJ55",
            "aircraftClasses": [
                "UNKNOWN"
            ],
            "aircraftTypeDescription": "Learjet 55",
            "airlineIcao": "VNT",
            "airlineName": "Avient Air Zambia Limited",
            "depAirportIcao": "KFRG",
            "updated": "2023-04-06T13:55:25.000+00:00",
            "status": "IN_FLIGHT"
        }]
      }
    it "show all data" do
      stub_request(:post, "https://api.radarbox.com/v2/flights/live").
         with(
           body: "{\"pageSize\":10,\"page\":1,\"aircraftTypes\":[\"BE99\"]}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer 93af31a9c785d864e65bb1e0340d96a214dc2485',
          'Content-Type'=>'application/json',
          'Host'=>'api.radarbox.com',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: JSON.dump(flight_data_res), headers: {})

      get :index, params: {aircraft_type: "BE99"}
      expect(response).to have_http_status(200)
    end
  end

end