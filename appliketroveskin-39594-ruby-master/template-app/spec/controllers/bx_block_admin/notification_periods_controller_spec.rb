require 'rails_helper'
RSpec.describe BxBlockAdmin::NotificationPeriodsController, type: :controller do

  describe 'GET indexs' do
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
      it 'Returns success' do
      	user = admin
      	create(:notification_period)
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        get :index, params: {token: token}
        sample = ["id", "notification_type", "period_type", "period", "created_at", "updated_at"]
        expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(sample)
        expect(response).to have_http_status(200)
      end
    end
  end

   describe 'PUT update' do
  	let(:admin) { create(:admin, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
	context "Only accessible to admin" do
      it 'Returns success' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        put :update, params: {token: token, id: 2345 }
        expect(response). to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
      end
    end
    context "when admin logged in" do
      it 'Returns success' do
      	user = admin
      	notification = create(:notification_period)
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        put :update, params: {token: token, id: notification.id, notification_period: { notification_type: "abandon_cart", period_type: "hours", period: 2} }, as: :json
        sample = ["id", "notification_type", "period_type", "period", "created_at", "updated_at"]
        expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
        expect(JSON.parse(response.body)['data']['attributes']['period_type']).to eql("hours")
        expect(response).to have_http_status(200)
      end
    end
     context "when admin logged in" do
      it 'Returns error in update' do
      	user = admin
      	notification = build_stubbed(:notification_period)
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        put :update, params: {token: token, id: notification.id, notification_period: { notification_type: "abandon_cart", period_type: "hours", period: 2} }, as: :json
        expect(JSON.parse(response.body)['errors']['message']).to eql("Notification Period with id 1001 doesn't exists")
        expect(response).to have_http_status(404)
      end
    end
  end
end
