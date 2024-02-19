require 'rails_helper'
require 'spec_helper'
RSpec.describe BxBlockBlogpostsmanagement::BlogsController, type: :controller do

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
    end
    context "when pass correct params" do
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
    end
    context "when pass correct params" do
      it 'Returns success' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :show, params: {use_route: '/products/', token: @token ,id: 79521054902, search_params: "api"}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET article' do
    before do
      @account = create(:account , freeze_account: false)
    end
    context "when pass correct params" do
      it 'Returns success' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :article, params: {use_route: '/products/', token: @token ,id: 79521054902, article_id: 557643169974, search_params: "api"}
        expect(response).to have_http_status(200)
      end
    end
  end

end
