require 'rails_helper'
RSpec.describe BxBlockPayments::SubscriptionsController, type: :controller do

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        create(:subscription, account: @account, is_cancelled: false)
        get :index, params: { use_route: "/payments/" , token: @token }
        expect(response).to have_http_status(200)
      end
    end
    context "when pass correct params" do
      it 'Returns empty list' do
        get :index, params: { use_route: "/payments/" , token: @token }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET SHOW' do
    before do
      @account = create(:account , freeze_account: false)
      @subscription =  create(:subscription, account: @account, is_cancelled: false)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        get :show, params: { use_route: "/payments/" , token: @token, id: @subscription.id }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST CREATE' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      card = Stripe::Token.create({card: {number: '4242424242424242',exp_month: 10,exp_year: 2023,cvc: '314',},})
      stripe_customer = Stripe::Customer.create({email: @account.email, source: card['id'],})
      @account.update(stripe_customer_id: stripe_customer.id)
    end

    context "when pass correct params" do
      it 'Returns success' do
        post :create, params: { use_route: "/payments/" , token: @token, subscription: { frequency: 'daily', amount: 100.00, is_cancelled: false } }
        expect(response).to have_http_status(201)
      end
      it 'Returns success' do
        post :create, params: { use_route: "/payments/" , token: @token, subscription: { frequency: 'weekly', amount: 100.00, is_cancelled: false } }
        expect(response).to have_http_status(201)
      end
      it 'Returns success' do
        post :create, params: { use_route: "/payments/" , token: @token, subscription: { frequency: 'uearly', amount: 100.00, is_cancelled: false } }
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT UPDATE' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @subscription = create(:subscription, account: @account)
    end

    context "when pass correct params" do
      it 'Returns success' do
        @subscription.update(frequency: 'daily')
        put :update, params: { use_route: "/payments/" , id: @subscription.id, token: @token, subscription: { frequency: 'daily', amount: 100.00, is_cancelled: false } }
        expect(response).to have_http_status(200)
      end
      it 'Returns success' do
        put :update, params: { use_route: "/payments/" , id: @subscription.id, token: @token, subscription: { frequency: 'weekly', amount: 100.00, is_cancelled: false } }
        expect(response).to have_http_status(200)
      end
      it 'Returns success' do
        put :update, params: { use_route: "/payments/" , id: @subscription.id, token: @token, subscription: { frequency: 'monthly', amount: 100.00, is_cancelled: false } }
        expect(response).to have_http_status(200)
      end
    end
  end

end
