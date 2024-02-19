require 'rails_helper'
RSpec.describe BxBlockDataImportExportCsv::ExportController, type: :controller do

describe 'GET index' do
before do
  @account = create(:account , freeze_account: false)
  @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
end

context "when we pass correct params for export csv" do
  it 'Returns success' do
    get :index, params: {token: @token}
    expect(response).to have_http_status(200)
  end
end
context "when we pass incorrect params for export csv" do
  it 'Returns Invalid token' do
    get :index, params: {token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
  end
end
  end

end
