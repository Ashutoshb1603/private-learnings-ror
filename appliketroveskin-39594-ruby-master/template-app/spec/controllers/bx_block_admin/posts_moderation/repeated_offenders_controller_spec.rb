require 'rails_helper'
RSpec.describe BxBlockAdmin::PostsModeration::RepeatedOffendersController, type: :controller do

	describe 'GET index ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			question = create(:question, accountable: @account)
			create(:comment, objectable: question, offensive: true, accountable: @account)
		end
		context "When admin logged in" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :index, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "name", "full_phone_number", "country_code", "phone_number", "email", "gender", "activated", "device", "offensive_posts", "offensive_comments"])
			end
		end
		context "When admin logged in" do
			it 'Returns pagination error' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :index, params: { token: token, page: 12345 }
				expect(response).to have_http_status(404)
				expect(JSON.parse(response.body)['message']).to eql("Page doesn't exist")
			end
		end
	end
end
