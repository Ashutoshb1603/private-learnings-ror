require 'rails_helper'
RSpec.describe BxBlockPayments::PlansController, type: :controller do
  let(:plan) { create(:plan) }

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
      plan
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        get :index, params: { use_route: "/payments/" , token: @token }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET SHOW' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        get :show, params: { use_route: "/payments/" , token: @token, id: plan.id }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST CREATE' do
    before do
      @account = create(:account , freeze_account: false)
      @plan = create(:plan)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        post :create, params: { use_route: "/payments/" , token: @token, plan: { price_cents: 156.00, name: "My plan", interval: "month", duration: 'month', period: 'month', price: 156.00} }
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT update' do
    before do
      @account = create(:account , freeze_account: false)
      @payment = create(:payment, account: @account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        @plan = create(:plan)
        put :update, params: { use_route: "/payments/" , token: @token , notification: { } }
        expect(response).to have_http_status(204)
      end
    end
  end

 describe 'DELETE destroy' do
    before do
      @account = create(:account , freeze_account: false)
      @payment = create(:payment, account: @account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        @plan = create(:plan)
        delete :destroy, params: { use_route: "/payments/" , token: @token }
        expect(response).to have_http_status(204)
      end
    end
  end

end
