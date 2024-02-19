require 'rails_helper'
RSpec.describe AccountBlock::Account, type: :request do
  before :context do
    @account = FactoryBot.create(:Account, email: Faker::Internet.safe_email,user_name: "test", full_name:  Faker::Internet.name, password: "123456")
    @token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @request_params = { token: @token, format: :json }
    @headers = {token: @token, format: :json }
  end

  describe 'delete#destroy' do
    context 'delete for account' do
      it "DELETE will cause an exception" do
        account = @account
        delete "/bx_block_feature_settings/delete_accounts",headers: @headers,params: @request_params
        expect(response).to have_http_status 200
      end
    end
  end
end