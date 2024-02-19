require 'rails_helper'
RSpec.describe BxBlockCategories::SubCategoriesController, type: :controller do

describe 'POST create' do
  before do
    @account = create(:account , freeze_account: false)
    @sub_category = create(:sub_category)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end
  context "when pass correct  params" do
    it 'Returns created SubCategory' do
      post :create, params: {use_route: '/sub_categories/' , token: @token , sub_category: { name: @sub_category }}
      expect(response).to have_http_status(201)
    end
  end

  context "when pass incorrect token" do
    it 'Returns Invalid token' do
      post :create, params: {token: nil}
      expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
  # context "when pass incorrect params" do
  #   it 'Returns Wrong input data' do
  #     post :create, params: {token: @token , sub_category: {name: ""}}
  #
  #     expect(JSON.parse(response.body)["errors"]["message"]).to eql("Wrong input data")
  #   end
  # end
end

describe 'GET show' do
  before do
    @account = create(:account , freeze_account: false)
    @sub_category = create(:sub_category)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when we pass correct params" do
    it 'Returns show sub category list' do
    get :show, params: {use_route: '/sub_categories/' , token: @token , id: @sub_category.id}

    expect(response).to have_http_status(200)
    end
  end
end

describe 'GET index' do
  before do
    @account = create(:account , freeze_account: false)
    @sub_category = create(:sub_category)
    @category = create(:category)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when we pass correct params" do
    it 'Returns list all sub category' do
      get :index, params: {use_route: '/sub_categories/' , token: @token , category_id: @category.id}
      expect(response).to have_http_status(200)
    end
  end
end


describe 'DELETE destroy' do
  before do
    @account = create(:account , freeze_account: false)
    @sub_category = create(:sub_category)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when we destroy SubCategory with correct params" do
    it 'Returns successfully destroy' do
    delete :destroy, params: {use_route: '/sub_categories/' , token: @token  , id: @sub_category.id}
    expect(JSON.parse(response.body)["success"]).to eql(true)
    end
  end

  context "when we destroy SubCategory with wrong id" do
    it "Returns SubCategory with id 1 doesn't exists" do
    delete :destroy, params: {use_route: '/sub_categories/' , token: @token  , id: 1}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("SubCategory with id 1 doesn't exists")

    end
  end

  context "when we list sub categories data with incorrect params" do
    it 'Returns Invalid token' do
    delete :destroy, params: {use_route: '/sub_categories/' , token: nil , id: @sub_category.id}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end


describe 'PATCH update' do
  before do
    @account = create(:account , freeze_account: false)
    @sub_category = create(:sub_category)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when we update SubCategory with correct params" do
    it 'Returns successfully updated ' do
    patch :update, params: {use_route: '/sub_categories/' , token: @token  , id: @sub_category.id  , sub_category: {name: "updated name" }}
    expect(response).to have_http_status(200)
    end
  end

  context "when we list sub categories data with incorrect params" do
    it 'Returns Invalid token' do
    patch :update, params: {use_route: '/sub_categories/',token: @token, sub_category: {name: "" } }
    expect(response).to have_http_status(404)
    end
  end

  context "when we destroy SubCategory with wrong id" do
    it "Returns SubCategory with id 1 doesn't exists" do
    patch :update, params: {use_route: '/sub_categories/' , token: @token  , id: 1}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("SubCategory with id 1 doesn't exists")
    end
  end
end

end

