require 'rails_helper'
RSpec.describe BxBlockCatalogue::AdvertisementsController, type: :controller do

  describe 'GET INDEX' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      create(:advertisement)
    end
    context "when correct token is passed" do
      it 'Returns created' do
      get :index, params: {token: @token}
      expect(response). to have_http_status(200)
      end
    end
    context "when country s passed with params" do
      it 'Returns created' do
      get :index, params: {token: @token, country: "United Kingdom"}
      expect(response). to have_http_status(200)
      end
    end
  end

  describe 'PUT UPDATE' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @ad = create(:advertisement)
    end
    context "when we create brand correct params" do
      it 'Returns created' do
      put :update, params: {token: @token, id: @ad.id}
      expect(response). to have_http_status(200)
      end
    end
    context "when pass incorrect id" do
      it 'Returns created' do
      put :update, params: {token: @token, id: 123456}
      expect(response). to have_http_status(404)
      expect(JSON.parse(response.body)['errors']['message']).to eql("Advertisement with id 123456 doesn't exists")
      end
    end
  end

end
