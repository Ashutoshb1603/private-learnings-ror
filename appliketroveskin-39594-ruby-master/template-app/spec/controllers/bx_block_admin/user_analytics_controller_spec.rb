require 'rails_helper'
RSpec.describe BxBlockAdmin::UserAnalyticsController, type: :controller do

  describe 'GET conversation_rates ' do
  	let(:admin) { create(:admin_user, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
    context "When admin logged in" do
    	it 'Returns success' do
	      	user = admin
	      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
	        get :conversation_rates, params: { token: token }
	        expect(response).to have_http_status(200)
	        expect(JSON.parse(response.body)['data'].keys).to match_array(["conversation_rates", "consultation_analytics", "abandoned_carts", "notifications"])
      	end
    end
  end

  describe 'GET top_spenders ' do
  	let(:admin) { create(:admin_user, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
    context "When admin logged in" do
    	it 'Returns success' do
	      	user = admin
	      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
	        get :top_spenders, params: { token: token, user_type: 'free' }
	        expect(response).to have_http_status(200)
	        expect(JSON.parse(response.body).keys).to match_array(["data", "meta"])
      	end
    end
    context "When admin logged in" do
    	it 'Returns success' do
	      	user = admin
	      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
	        get :top_spenders, params: { token: token, user_type: 'glow_getter' }
	        expect(response).to have_http_status(200)
	        expect(JSON.parse(response.body).keys).to match_array(["data", "meta"])
      	end
    end
    context "When admin logged in" do
    	before do
    		account = create(:account , freeze_account: false, location: "India")
      		address = create(:address, addressable: account )
      		order = create(:order , customer: account, address: address)
    	end
    	it 'Returns success' do
	      	user = admin
	      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
	        get :top_spenders, params: { token: token }
	        expect(response).to have_http_status(200)
	        expect(JSON.parse(response.body).keys).to match_array(["data", "meta"])
      	end
    end
  end

  describe 'GET top_favourites ' do
  	let(:admin) { create(:admin_user, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
      address = create(:address, addressable: @account )
      order = create(:order , customer: @account, address: address)
	  create(:line_item, order: order)
	  live_video = create(:live_video)
	  create(:skin_hub_view, account: @account, objectable: live_video)
    end
    context "When admin logged in" do
    	it 'Returns success' do
	      	user = admin
	      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
	        get :top_favourites, params: { token: token }
	        expect(response).to have_http_status(200)
	        expect(JSON.parse(response.body)['data'].keys).to match_array(["top_favourites", "average_live_views", "users_split"])
      	end
    end
  end

end
