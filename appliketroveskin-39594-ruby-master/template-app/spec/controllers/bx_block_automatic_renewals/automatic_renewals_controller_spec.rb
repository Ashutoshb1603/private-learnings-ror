require 'rails_helper'
require 'spec_helper'
RSpec.describe BxBlockAutomaticRenewals::AutomaticRenewalsController, type: :controller do

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
    end
    context "when pass correct params with no data" do
      it 'Returns list all products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: @token}
        expect(response).to have_http_status(200)
      end
    end
    context "when pass correct params with data" do
      before do
        create(:automatic_renewal, account: @account)
      end
      it 'Returns list all products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: @token}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET show' do
    before do
      @account = create(:account , freeze_account: false)
      @automatic_renewal = create(:automatic_renewal, account: @account)
    end
    context "when pass correct params" do
      it 'Returns success' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :show, params: {use_route: '/products/', token: @token ,id: @automatic_renewal.id}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST create' do
    before do
      @account = create(:account , freeze_account: false)
    end
    context "when pass correct params" do
      it 'Returns success' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :create, params: {use_route: '/products/', token: @token, auto_renew: { subscription_type: "Type", is_auto_renewal: false}}
        expect(response).to have_http_status(201)
      end
    end
    context "when pass incorrect params" do
      it 'Returns error' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :create, params: {use_route: '/products/', token: @token, auto_renew: { is_auto_renewal: false}}
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql(["Subscription type can't be blank"])
      end
    end
  end

  describe 'PUT UPDATE' do
    before do
      @account = create(:account , freeze_account: false)
      @automatic_renewal = create(:automatic_renewal, account: @account)
    end
    context "when pass correct params" do
      it 'Returns success' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        put :update, params: {use_route: '/products/', token: @token, id: @automatic_renewal.id, auto_renew: { subscription_type: "Type", is_auto_renewal: false}}
        expect(response).to have_http_status(200)
      end
    end
    context "when pass incorrect params" do
      it 'Returns error' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        put :update, params: {use_route: '/products/', token: @token, id: 2134567, auto_renew: { is_auto_renewal: false}}
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['message']).to eql("Record not found.")
      end
    end
  end

end
