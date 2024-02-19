require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::BusinessAircraftOnMajorAirportsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
    
  end

  describe "Get#index" do
    aircraft_data_res = {
      "cost": 1,
      "success": true,
      "statistics": [
        {
          "day": "2023-04-07",
          "airportStatistics": [
            {
              "icaoCode": "VABB",
              "totalFlights": 30
            }
          ]
        }
      ]
    }

    it "show all data" do
      stub_request(:get, "https://api.radarbox.com/v2/statistics/airports/business").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer 93af31a9c785d864e65bb1e0340d96a214dc2485',
          'Host'=>'api.radarbox.com',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: JSON.dump(aircraft_data_res), headers: {})

      get :index
      expect(response).to have_http_status(200)
    end
  end

end