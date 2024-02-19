# frozen_string_literal: true

require 'rails_helper'

describe BxBlockCfflexapi2::GenerateLeonRefreshTokenJob do
  before(:each) do
    @account = FactoryBot.create(:account, leon_access_token: "xyz", leon_refresh_token: "abc", leon_client_id: '63b5d45ea3f3d8.36634412')
    stub_request(:post, "https://man.sandbox.leon.aero/oauth2/code/authorize/?client_id=63b5d45ea3f3d8.36634412&redirect_uri=https://26c3-15-206-64-22.ngrok.io/bx_block_inventorymanagement2/leons/leon_auth_data&response_type=code&scope%5B%5D=GRAPHQL_ACFT&scope%5B%5D=GRAPHQL_AIRCRAFT_AVAILABILITY&scope%5B%5D=GRAPHQL_AIRPORT&scope%5B%5D=GRAPHQL_OPERATOR").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'multipart/form-data',
          'Host'=>'man.sandbox.leon.aero',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "", headers: {})
     
  end
  describe "#perform_later" do
    it "does that" do
      ActiveJob::Base.queue_adapter = :test
      result = BxBlockCfflexapi2::TokenGenerateService.create_refresh_token()
    end
  end
end
