require 'rails_helper'
RSpec.describe BxBlockCategories::CategoriesController, type: :controller do

  describe 'POST create' do
    before do
      @account = create(:account , freeze_account: false)
      @category = create(:category)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when we create categories with correct params" do
      it 'Returns success' do
        post :create, params: {token: @token , categories: [ {name: "test1" } ] }
        expect(response). to have_http_status(201)
      end
    end
    context "when we create categories with incorrect params" do
      it 'Returns Invalid token' do
        post :create, params: {token: nil}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end

  describe 'GET show' do
    before do
      @account = create(:account , freeze_account: false)
      @category = create(:category)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when we show categories with correct params" do
      it 'Returns success' do
        get :show, params: {token: @token , id: @category.id}
        expect(response). to have_http_status(200)
      end
    end
    context "when we show categories with incorrect params" do
      it 'Returns Invalid token' do
        get :show, params: {token: nil , id: @category.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
      @category = create(:category)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when we list categories with correct params" do
      it 'Returns success' do
        get :index, params: {token: @token , id: @category.id}
        expect(response). to have_http_status(200)
      end
    end
    context "when we list categories with incorrect params" do
      it 'Returns Invalid token' do
        get :index, params: {token: nil , id: @category.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
  end
end

  describe 'PATCH update' do
    before do
      @account = create(:account , freeze_account: false)
      @category = create(:category)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when we update categories with correct params" do
      it 'Returns success' do
        patch :update, params: {token: @token , id: @category.id ,  category: {category_name: "test1" } }
        expect(response). to have_http_status(200)
      end
    end
    context "when we update categories with incorrect params" do
      it 'Returns Invalid token' do
        patch :update, params: {use_route: 'categories' , token: nil , id: @category.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end


  describe 'DELETE destroy' do
    before do
      @account = create(:account , freeze_account: false)
      @category = create(:category)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when we pass correct params for destroy" do
      it 'Returns DELETE' do
        delete :destroy, params: {token: @token , id: @category.id  }
        expect(response). to have_http_status(200)
      end
    end
    context "when we pass correct params for destroy" do
      it 'Returns Invalid token' do
        delete :destroy, params: {token: nil , id: @category.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end

end
