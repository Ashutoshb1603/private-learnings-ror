require 'rails_helper'
RSpec.describe BxBlockCatalogue::BrandsController, type: :controller do

describe 'POST create' do
  before do
    @account = create(:account , freeze_account: false)
    @brand = create(:brand)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end
  context "when we create brand correct params" do
    it 'Returns created' do
    post :create, params: {token: @token}
    expect(response). to have_http_status(201)
    end
  end
  # context "when pass incorrect params" do
  #   it 'Returns created' do
  #   post :create, params: {token: @token}
  #   expect(response). to have_http_status(201)
  #   end
  # end
end
describe 'GET index' do
  before do
    @account = create(:account , freeze_account: false)
    @brand = create(:brand)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end
  context "when we list brand correct params" do
    it 'Returns list all brand' do
      get :index, params: {token: @token}
      expect(response). to have_http_status(200)
    end
  end
end
end
