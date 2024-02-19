require 'rails_helper'
RSpec.describe BxBlockAdmin::OrdersController, type: :controller do

  describe 'GET index' do
  	let(:admin) { create(:admin, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
	context "Only accessible to admin" do
      it 'Returns success' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: token}
        expect(response). to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
      end
    end
    context "when admin logged in" do
      it 'Returns success when at params is present' do
      	address = create(:address, addressable: @account )
      	order = create(:order , customer: @account, address: address)
      	user = admin
      	create(:notification_period)
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        get :index, params: { token: token }
        sample = ["id", "order_id", "status", "email", "phone", "financial_status", "line_items", "customer", "discount", "subtotal_price", "total_price", "shipping_charges", "shipping_title", "requires_shipping", "billing_address", "shipping_address", "created_at", "transaction_id", "way_of_payment", "currency", "shopify_attributes"]
        expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(sample)
        expect(response).to have_http_status(200)
      end
    end
     context "when admin logged in" do
      it 'Returns success when at params is present' do
      	address = create(:address, addressable: @account )
      	order = create(:order , customer: @account, address: address)
      	user = admin
      	create(:notification_period)
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        get :index, params: { token: token, page: 2345 }, as: :json
        expect(JSON.parse(response.body)['message']).to eql("Page doesn't exist")
        expect(JSON.parse(response.body)['error']).to eql("expected :page in 1..1; got 2345")
        expect(response).to have_http_status(404)
      end
    end
  end
end
