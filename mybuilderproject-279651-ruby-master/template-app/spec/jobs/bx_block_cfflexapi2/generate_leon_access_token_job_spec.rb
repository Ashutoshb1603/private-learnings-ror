# frozen_string_literal: true

require 'rails_helper'

describe BxBlockCfflexapi2::GenerateLeonAccessTokenJob do
  before(:each) do
      @account = FactoryBot.create(:account, leon_access_token: "xyz", leon_refresh_token: "abc", leon_client_id: '63b5d45ea3f3d8.36634412')
      stub_request(:post, "https://man.sandbox.leon.aero/access_token/refresh/").
         with(
           body: {"refresh_token"=>"abc"},
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Length'=>'17',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'Host'=>'man.sandbox.leon.aero',
          'User-Agent'=>'rest-client/2.1.0 (linux-musl x86_64) ruby/2.6.5p114'
           }).
         to_return(status: 200, body: "", headers: {})
  end
  describe "#perform_later" do
    it "does that" do
      ActiveJob::Base.queue_adapter = :test
      result = BxBlockCfflexapi2::TokenGenerateService.create_access_token()
    end
  end
end
