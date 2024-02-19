require 'rails_helper'
RSpec.describe BxBlockAdmin::PostsModeration::BadWordsetsController, type: :controller do

	describe 'GET index ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			create(:bad_wordset)
		end
		context "When admin logged in" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :index, params: { token: token }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'PUT update ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "When admin logged in" do
			it 'Returns success' do
				bad = create(:bad_wordset)
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				put :update, params: { token: token, id: bad.id, word: "bad word" }
				expect(response).to have_http_status(200)
			end
		end
		context "When admin logged in" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				put :update, params: { token: token, id: 12345, word: "bad word" }
				expect(response).to have_http_status(200)
			end
		end
	end

end
