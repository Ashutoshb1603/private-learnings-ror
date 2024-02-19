require 'rails_helper'
require 'spec_helper'
RSpec.describe BxBlockShoppingCart::OrdersController, type: :controller do
  before do
    @shopify = BxBlockShopifyintegration::ShopifyOrdersController.new({country: 'United Kingdom'})
    @therapist = create(:email_account, :with_therapist_role)
  end

  describe 'POST create' do
    before do
      @account = create(:account , freeze_account: false)
      @address = create(:address, addressable: @account )
      @cart_item = create(:cart_item, variant_id: "42503800651995", product_id:"7549054517467", quantity: 1, price: 14.00, name: "Aubergine Lip Pencil", product_image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/auberginepencil.jpg?v=1645521708", account: @account)
    end
    context "when pass correct params" do
      it 'Returns success' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :create, params: {token: @token, order: { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: true, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1" } }, as: :json
        expect(response).to have_http_status(200)
      end
    end

    context "when pass correct params" do
      before do
        recommended_product = create(:recommended_product, account: @account, parentable: @therapist, title: "Aubergine Lip Pencil", price: 14.00, product_id: "7549054517467")
      end
      it 'Returns update recommend products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
         post :create, params: {token: @token, order: { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: false, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1" } }
        expect(response).to have_http_status(200)
      end
    end

    context "when pass correct params with discount codes" do
      before do
        create(:membership_plan, account: @account, plan_type: 'glow_getter', end_date: 1.month.after)
      end
      it 'Returns update recommend products' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
         post :create, params: {token: @token, order: { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: true, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1", discount_codes: [{ code: "GDIS", type: "percentage", amount: '10'}] } }
        expect(response).to have_http_status(200)
      end
    end

    context "when incorrect line items" do
      it 'Returns must have at least one line item' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :create, params: {token: @token, order: { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: true, cart_item_ids: [1], transaction_id: "TRANSACTION1" } }, as: :json
        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)['errors']['line_items']).to eql( ["must have at least one line item"])
      end
    end
  end
  describe 'GET show' do
    before do
      @account = create(:account , freeze_account: false)
      @address = create(:address, addressable: @account )
      @cart_item = create(:cart_item, variant_id: "42503800651995", product_id:"7549054517467", quantity: 1, price: 14.00, name: "Aubergine Lip Pencil", product_image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/auberginepencil.jpg?v=1645521708", account: @account)
      order_params = { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: false, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1" }
      @shopify_order = @shopify.create_orders(@account, order_params)
      @order = create(:order , customer: @account, address: @address)
    end
    context "when pass correct params" do
      it 'Returns show all orders' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :show, params: {use_route: '/orders/', token: @token, id: @order.order_id}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql("Order does not exist")
      end
    end

    context "when pass correct params" do
      it 'Returns success' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :show, params: {use_route: '/orders/' ,  token: @token , id: @order.id}
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Order does not exist")
      end
    end
  end

  describe 'GET past_orders' do
    before do
      @account = create(:account , freeze_account: false)
      @address = create(:address, addressable: @account )
      @order = create(:order, customer: @account, address: @address)
    end
    context "when pass correct params" do
      it 'Returns Show past orders' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :past_orders, params: {use_route: '/orders/' ,  token: @token }
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql("Order does not exist")
      end
    end
    context "when pass incorrect token" do
      it 'Returns Invalid token' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :past_orders, params: {use_route: '/orders/' ,  token: @nil }
        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Invalid token")
      end
    end
    context "when pass incorrect page item" do
      it "Returns Page doesn't exist" do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :past_orders, params: {use_route: '/orders/' ,  token: @token ,page: 100, items: 10000}
        expect(response).to have_http_status(404)

        expect(JSON.parse(response.body)['message']).to eql("Page doesn't exist")
      end
    end
  end

  describe 'GET locations' do
    before do
      @account = create(:account , freeze_account: false)
      @admin_user = create(:admin_user)
      @address = create(:address, addressable: @admin_user , shopify_address_id: "67026223323")

    end
    context "when pass correct params" do
      it 'Returns Show locations' do
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :locations, params: {use_route: '/orders/' ,  token: @token }
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql("Order does not exist")
      end
    end
  end

  # describe 'PUT cancel' do
  #   before do
  #     @account = create(:account , freeze_account: false)
  #     @address = create(:address, addressable: @account )
  #     @cart_item = create(:cart_item, variant_id: "42503800651995", product_id:"7549054517467", quantity: 1, price: 14.00, name: "Aubergine Lip Pencil", product_image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/auberginepencil.jpg?v=1645521708", account: @account)
  #     order_params = { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: false, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1" }
  #     @shopify_order = @shopify.create_orders(@account, order_params)
  #     @order = create(:order , customer: @account, address: @address, order_id: @shopify_order["order"]["id"])
  #   end
  #   context "when pass correct params" do
  #     it 'Returns Show locations' do
  #       @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  #       put :cancel, params: {use_route: '/orders/' ,  token: @token, id: @order.order_id, order:{reason: "test reason", email: @account.email, amount: 14.00}}, as: :json
  #       expect(response).to have_http_status(500)
  #       expect(JSON.parse(response.body)['errors']['message']).to eql( "Unsuccessful refund.")
  #     end
  #   end
  # end
end
