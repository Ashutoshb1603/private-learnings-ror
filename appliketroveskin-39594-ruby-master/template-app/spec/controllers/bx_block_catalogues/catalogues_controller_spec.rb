require 'rails_helper'
RSpec.describe BxBlockCatalogue::CataloguesController, type: :controller do
  describe 'POST create' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @category = create(:category)
      @sub_category = create(:sub_category)
    end
    context "when we create catalogues correct params" do
      it 'Returns created' do
        post :create, params: {token: @token, category_id: @category.id, sub_category_id: @sub_category.id}
        expect(response). to have_http_status(201)
      end
    end

    context "when we create catalogues incorrect params" do
      it 'Returns errors' do
        post :create, params: {token: @token}
        expect(response). to have_http_status(422)
      end
    end
    context "when we create catalogues incorrect params" do
      it 'Returns Invalid token' do
        post :create, params: {token: nil}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end
  describe 'GET show' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when we show catalogues correct params" do
      it 'Returns success' do
      sub_category = create(:sub_category)
      category = create(:category)
      catalogue = create(:catalogue, sub_category: sub_category, category: category)
      get :show, params: {use_route: '/catalogues/' ,  token: @token, id: catalogue.id }
      expect(response). to have_http_status(200)
      sample = ["category", "sub_category", "brand", "tags", "reviews", "name", "sku", "description", "manufacture_date", "length", "breadth", "height", "stock_qty", "availability", "weight", "price", "recommended", "on_sale", "sale_price", "discount", "images", "average_rating", "catalogue_variants"]
      expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
      end
    end
    context "when we show catalogues incorrect params" do
      it 'Returns Invalid token' do
        get :show, params: {use_route: '/catalogues/' , token: nil}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
    context "when id is not present" do
      it 'Returns Invalid token' do
        get :show, params: {use_route: '/catalogues/' ,  token: @token, id: 999999 }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Catalogue with id 999999 doesn't exists")
      end
    end
  end
  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @category = create(:category)
      @sub_category = create(:sub_category)
    end
    context "when we pass valid token" do
      it 'Returns success' do
        catalogue = create(:catalogue, sub_category: @sub_category, category: @category)
        get :index, params: {token: @token}
        sample = ["category", "sub_category", "brand", "tags", "reviews", "name", "sku", "description", "manufacture_date", "length", "breadth", "height", "stock_qty", "availability", "weight", "price", "recommended", "on_sale", "sale_price", "discount", "images", "average_rating", "catalogue_variants"]
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(sample)
      end
    end
    context "when we pass Invalid token" do
      it 'Returns Invalid token' do
        get :index, params: {token: nil}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end
  describe 'DELETE destroy' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @category = create(:category)
      @sub_category = create(:sub_category)
    end
    context "when we pass valid token" do
      it 'Returns success' do
        catalogue = create(:catalogue, sub_category: @sub_category, category: @category)
        delete :destroy, params: {token: @token, id: catalogue.id}
        expect(response).to have_http_status(200)
      end
    end

    context "when we create catalogues incorrect params" do
      it 'Returns errors' do
        delete :destroy, params: {use_route: '/catalogues/' , token: @token}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT update' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @category = create(:category)
      @sub_category = create(:sub_category)
    end
    context "when we pass valid token" do
      it 'Returns success' do
        catalogue = create(:catalogue, sub_category: @sub_category, category: @category)
        put :update, params: {token: @token, id: catalogue.id}
        expect(response).to have_http_status(200)
      end
    end

    context "when we create catalogues incorrect params" do
      it 'Returns errors' do
        put :update, params: {use_route: '/catalogues/' ,token: @token}
        expect(response).to have_http_status(404)
      end
    end
  end

end
