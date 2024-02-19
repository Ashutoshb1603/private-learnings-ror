require 'rails_helper'
RSpec.describe BxBlockAdmin::NotificationsController, type: :controller do

  describe 'POST create' do
  	let(:admin) { create(:admin, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
	context "Only accessible to admin" do
      it 'Returns success' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :create, params: {token: token}
        expect(response). to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
      end
    end
    context "when admin logged in" do
      it 'Returns success when at params is present' do
      	user = admin
      	create(:notification_period)
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        post :create, params: {token: token, data: { attributes: { title: "My Title", message: "My message", at: Time.now } }}
        expect(JSON.parse(response.body)['message']).to eql("Notification scheduled.")
        expect(response).to have_http_status(200)
      end
    end
    context "when admin logged in" do
      it 'Returns differenet response when at params is not present' do
      	user = admin
      	create(:notification_period)
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        post :create, params: {token: token, data: { attributes: { title: "My Title", message: "My message" } }}
        expect(JSON.parse(response.body)['message']).to eql("Notification sent.")
        expect(@account.notifications.first.contents).to eql("My Title")
        expect(response).to have_http_status(200)
      end
    end
  end
end
