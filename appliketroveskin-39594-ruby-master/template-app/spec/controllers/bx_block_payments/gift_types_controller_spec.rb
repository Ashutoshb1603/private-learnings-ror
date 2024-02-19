require 'rails_helper'
RSpec.describe BxBlockPayments::GiftTypesController, type: :controller do

describe 'GET index' do
  before do
    @account = create(:account , freeze_account: false)
    @wallet = create(:wallet, account: @account)
    @wallet_transaction = create(:wallet_transaction)
    @gift_type = create(:gift_type)
    @payment = create(:payment, account: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
    get :index, params: { use_route: "/payments/" , token: @token }
    expect(response).to have_http_status(200)
    end
  end
end
end
