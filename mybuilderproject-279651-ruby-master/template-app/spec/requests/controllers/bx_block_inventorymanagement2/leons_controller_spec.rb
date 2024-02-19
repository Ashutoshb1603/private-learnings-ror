require 'rails_helper'
RSpec.describe BxBlockInventorymanagement2::LeonsController, type: :controller do
  before(:each) do
    res_body = {access_token: "124", refresh_token: "123"}
    aircraft_body = {data: { aircraftAvailability: { availabilityList: [{ aircraft: { aircraftNid: 2099, acftTypeId: "G450", acftType: { acftTypeId: "G450" },operator: {name: "Manual"}, category: { categoryName: "Heavy jet" }}}]}}}
    @account = FactoryBot.create(:account, leon_client_id: '63b5d45ea3f3d8.36634412', leon_client_sceret: '74d2097d27f880f27fc2e3d08e354753670cba6204053ce3110d2c12ab39aef2')
    @token = stub_request(:post, "https://man.sandbox.leon.aero/oauth2/code/token/").
         with(
           body: {"client_id"=>"63b5d45ea3f3d8.36634412", "client_secret"=>"74d2097d27f880f27fc2e3d08e354753670cba6204053ce3110d2c12ab39aef2", "code"=>"xyz", "grant_type"=>"authorization_code", "redirect_uri"=>"https://26c3-15-206-64-22.ngrok.io/bx_block_inventorymanagement2/leons/leon_auth_data"},
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Length'=>'262',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'Host'=>'man.sandbox.leon.aero',
          'User-Agent'=>'rest-client/2.1.0 (linux-musl x86_64) ruby/2.6.5p114'
           }).
         to_return(status: 200, body: JSON.dump(res_body), headers: {})

        @code = stub_request(:post, "https://man.sandbox.leon.aero/oauth2/code/authorize/?client_id=63b5d45ea3f3d8.36634412&redirect_uri=https://26c3-15-206-64-22.ngrok.io/bx_block_inventorymanagement2/leons/leon_auth_data&response_type=code&scope%5B%5D=GRAPHQL_ACFT&scope%5B%5D=GRAPHQL_AIRCRAFT_AVAILABILITY&scope%5B%5D=GRAPHQL_AIRPORT&scope%5B%5D=GRAPHQL_OPERATOR").
         with(
           body: {"authorization"=>"1", "login"=>"ateroid2", "password"=>"kw^A4Ksrmc"},
           headers: {
          'Accept'=>'application/json',
          'Accept-Charset'=>'utf-8',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Basic QUMyMTk4Y2E5NGY1NzM0NTQzZGJmYzgzMTMwNjM2YzhkMjo0MDBiMWQ1YmU3YTAxMDIxNTk1MTc5M2RiZmNiZDc3NQ==',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'twilio-ruby/5.58.3 (ruby/x86_64-linux 2.6.5-p114)'
           }).
         to_return(status: 200, body: "xyz", headers: {})
         @aircraft = stub_request(:post, "https://man.sandbox.leon.aero/api/graphql/").
         with(
           body: {"query"=>"{ aircraftAvailability { availabilityList(startTime: \"2023-03-24\", registration: null) { aircraft { aircraftNid acftTypeId acftType { acftTypeId icao iata easa name shortName typeName acKind isAircraft isHelicopter } operator { oprNid oprId name } category { categoryNid categoryName hierarchy } registration acftTypeName } recordList { location { locationNid name } } } }}"},
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer 124',
          'Content-Length'=>'429',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'Host'=>'man.sandbox.leon.aero',
          'User-Agent'=>'rest-client/2.1.0 (linux-musl x86_64) ruby/2.6.5p114'
           }).
         to_return(status: 200, body: JSON.dump(aircraft_body), headers: {})

    end
  describe '#leon_auth_data' do
    it "should create leon aircraft data" do
      post :leon_auth_data, params: {code: "xyz"}
      JSON.parse(response.body)
    end
  end
end
