require 'rails_helper'
require 'spec_helper'
RSpec.describe BxBlockCatalogue::ProductsController, type: :controller do

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
    end
    context "when pass correct params" do
      it 'Returns list all products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: @token, search_params: "=A"}
        expect(response).to have_http_status(200)
      end
    end

    context "when pass correct params" do
      it 'Returns list all products' do
        @account.update(location: "Ireland")
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: @token, search_params: "=A"}
        expect(response).to have_http_status(200)
      end
    end

    context "when pass incorrect params" do
      it 'Returns list all products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: @token, search_params: "uk_products"}
        expect(response).to have_http_status(200)
      end
    end

    context "when pass incorrect params" do
      it 'Returns list all products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: @token, search_params: "ireland"}
        expect(response).to have_http_status(200)
      end
    end

    context "when pass collection id params" do
      it 'Returns list all products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: @token, search_params: "ireland_products", collection_id: @product_collection_view.collection_id}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET show' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
      @product_video = create(:product_video)
    end
    context "when pass correct params" do
      it 'Returns show all products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :show, params: {use_route: '/products/', token: @token ,id: "7549058318555"}
        expect(response).to have_http_status(200)
      end
    end
    context "when pass incorrect params" do
      it 'Returns Not Found' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :show, params: {use_route: '/products/', token: @token}
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"currency"=>"GBP", "errors"=>"Not Found", "in_cart"=>false, "is_favourite"=>false, "video"=>""})
      end
    end
  end

  describe 'GET recommendation' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
      @product_video = create(:product_video)
    end
    context "when pass correct params" do
      it 'Returns recommendation products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :recommendation, params: {use_route: '/products/', token: @token}
        expect(response).to have_http_status(200)
      end
    end
    context "when pass search_params" do
      it 'Returns recommendation products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :recommendation, params: {use_route: '/products/', token: @token , search: @account}

        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST set_as_favourite' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
      @product_video = create(:product_video)
    end
    context "when pass correct params" do
      it 'Returns Product added as favourite' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :set_as_favourite, params: {use_route: '/products/', token: @token , product_id: @product_video.product_id}
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['message']).to eql("Product added as favourite")

      end
    end
  end


  describe 'GET favourites' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
      @product_video = create(:product_video)
    end
    context "when pass correct params" do
      it 'Returns Product added from favourites' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :favourites, params: {use_route: '/products/', token: @token , product_id: @product_video.product_id}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql(["Product added from favourites"])
      end
    end
  end


  # describe 'DELETE remove_favourite' do
  #   before do
  #     @account = create(:account , freeze_account: false)
  #     @product_collection_view = create(:product_collection_view , accountable:@account)
  #     @product_video = create(:product_video)
  #   end
  #   context "when pass correct params" do
  #     it 'Returns Product removed from favourites' do
  #       @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  #       delete :remove_favourite, params: {use_route: '/products/', token: @token}

  #       expect(response).to have_http_status(200)
  #       expect(JSON.parse(response.body)['errors']['message']).to eql(["Product removed from favourites"])
  #     end
  #   end
  # end

  describe 'GET product_library' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
      @product_video = create(:product_video)
    end
    context "when pass correct params" do
      it 'Returns show all product library' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :product_library, params: {use_route: '/products/', token: @token}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql(["Product removed from favourites"])
      end
    end
  end

  describe 'GET hero_products' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
      @product_video = create(:product_video)
    end
    context "when pass correct params" do
      it 'Returns show all hero products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :hero_products, params: {use_route: '/products/', token: @token}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql(["Product removed from favourites"])
      end
    end
  end

  describe 'POST recommend_product' do
    before do
      @account = create(:account , freeze_account: false)
      @product_collection_view = create(:product_collection_view , accountable:@account)
      @product_video = create(:product_video)
    end
    context "when pass incorrect params" do
      it 'Returns parameter missing"' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :recommend_product, params: {use_route: '/products/', token: @token}
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("parameter missing")
      end
    end

    context "when pass correct params" do
      it 'Returns show recommend product' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :recommend_product, params: {use_route: '/products/', token: @token , product_id: "7549058318555"}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql(["parameter missing"])
      end
    end
  end


  describe 'GET refresh_products' do
    before do
      @account = create(:account , freeze_account: false)
    end

    context "when pass correct params" do
      it 'Returns show recommend product' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :refresh_products, params: {use_route: '/products/', data: "Ireland"}, as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql(["parameter missing"])
      end
    end
    context "when pass correct params" do
      it 'Returns show recommend product' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :refresh_products, params: {use_route: '/products/', data: "United Kingdom"}, as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql(["parameter missing"])
      end
    end
  end
end
