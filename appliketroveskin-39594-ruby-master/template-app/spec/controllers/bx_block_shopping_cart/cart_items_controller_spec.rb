require 'rails_helper'
require 'spec_helper'

RSpec.describe BxBlockShoppingCart::CartItemsController, type: :controller do
  describe 'POST create' do
    before do
      @account = create(:account,  freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass freezed account params" do
      it 'Returns cannot create card item Please Unfreeze first' do
        token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        @account.update(jwt_token: @account.jwt_token, freeze_account: true)
        post :create, params: { token: @token ,   data: { type: "cart_item", attributes: { product_id: 7549058744539, variant_id: 42503809925339, quantity: 1, price: "42.00", name: "ACE Body Oil", product_image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/100ml-body-oil-with-shadow-508x720-1301c14b-191f-44b9-8030-ceda26cc4425_350x350_a6498e01-304a-4afa-8a8d-05cb26550853.png?v=1645521988" } } }
        expect(JSON.parse(response.body)).to eq({"errors"=> {"message"=>"Account is Freezed. Please Unfreeze first"}})
      end
    end

    context "when we pass correct params" do
      it 'Returns success' do
        post :create, params: { token: @token ,   data: { type: "cart_item", attributes: { product_id: 7549058744539, variant_id: 42503809925339, quantity: 1, price: "42.00", name: "ACE Body Oil", product_image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/100ml-body-oil-with-shadow-508x720-1301c14b-191f-44b9-8030-ceda26cc4425_350x350_a6498e01-304a-4afa-8a8d-05cb26550853.png?v=1645521988" } } }
        expect(response).to have_http_status(200)
      end
    end

      it 'Returns Invalid token' do
        post :create, params: { token: nil  , data: { type: "cart_item", attributes: { product_id: 7549058744539, variant_id: 42503809925339, quantity: 1, price: "42.00", name: "ACE Body Oil", product_image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/100ml-body-oil-with-shadow-508x720-1301c14b-191f-44b9-8030-ceda26cc4425_350x350_a6498e01-304a-4afa-8a8d-05cb26550853.png?v=1645521988" } } }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
  end

  describe 'GET index' do
    before do
      @account = create(:account,  freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when we create card item correct params" do
       it 'Returns success' do
        get :index, params: { token: @token }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET show' do
    before do
      @account = create(:account , freeze_account: false)
      @cart_item = create(:cart_item, account: @account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token , account_type: @account.type}, 1.year.from_now)
    end
    let(:cart_item) { create(:cart_item, account: @account) }
    context "when pass correct params"
    it 'Returns success' do
      get :show, params: { use_route: "/cart_items/" , token: @token ,  id: cart_item.id}
      sample = ["product_id", "variant_id", "name", "quantity", "price", "total_price", "product_image_url", "currency"]
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
    end
  end

  describe 'GET get_taxes_and_shipping_charges' do
    before do
      @account = create(:account,  freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when we create get taxes and shipping charges" do
      it 'Returns success' do
      post :get_taxes_and_shipping_charges, params: { token: @token }
      expect(response).to have_http_status(200)
      end
    end

    context "when we create get taxes and shipping charges in incorrect params" do
      it 'Returns Invalid token' do
      post :get_taxes_and_shipping_charges, params: { token: nil }
      expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end

  describe 'POST apply_discount' do
    before do
      @account = create(:account,  freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when we apply discount correct params" do
      it 'Returns Discount applied!' do
      post :apply_discount, params: { token: @token }
      expect(JSON.parse(response.body)["message"]).to eql("Discount applied!")
      end
    end
  end

  describe 'PUT update_quantity' do
    before do
      @account = create(:account,  freeze_account: false)
      @cart_item = create(:cart_item, account: @account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    let(:cart_item) { create(:cart_item, account: @account) }

    context "when we update quantity correct params" do
       it 'Returns success' do
        id = cart_item.id
        put :update_quantity, params: {use_route: "/cart_items/" , id: id , token: @token , data: { type: "cart_item", attributes: { action:"add", quantity:3 } } }, as: :json
        sample = ["product_id", "variant_id", "name", "quantity", "price", "total_price", "product_image_url", "currency"]
        expect(response).to have_http_status(200)
        expect(BxBlockShoppingCart::CartItem.find(id).quantity).to eq(4)
        expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
      end
    end
  end

  describe 'PUT update' do
    before do
      @account = create(:account,  freeze_account: false)
      @cart_item = create(:cart_item, account: @account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    let(:cart_item) { create(:cart_item, account: @account) }

    context "when we update quantity correct params" do
       it 'Returns success' do
        id = cart_item.id
        put :update, params: {use_route: "/cart_items/" , id: id , token: @token , data: { type: "cart_item", attributes: { quantity:3 } } }, as: :json
        sample = ["product_id", "variant_id", "name", "quantity", "price", "total_price", "product_image_url", "currency"]
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
      end
    end
  end


  describe 'DELETE destroy' do
    before do
      @account = create(:account,  freeze_account: false)
      @cart_item = create(:cart_item, account: @account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    let(:cart_item) { create(:cart_item, account: @account) }

    context "when we pass correct params for destroy user" do
       it 'Returns successfully deleted' do
        delete :destroy, params: {use_route: "/cart_items/" , id: cart_item.id , token: @token }
        expect(JSON.parse(response.body)["message"]).to eql("successfully deleted")
      end
    end
  end
end
