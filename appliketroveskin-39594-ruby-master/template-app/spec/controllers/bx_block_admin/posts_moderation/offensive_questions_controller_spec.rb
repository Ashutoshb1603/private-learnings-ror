require 'rails_helper'
RSpec.describe BxBlockAdmin::PostsModeration::OffensiveQuestionsController, type: :controller do

	describe 'GET index ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			question = create(:question, accountable: @account, offensive: true)
		end
		context "When admin logged in" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :index, params: { token: token }
				expect(response).to have_http_status(200)
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

	describe 'PUT approve ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "When admin logged in" do
			it 'Returns success' do
				question = create(:question, accountable: @account)
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				put :approve, params: { token: token, id: question.id }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['message']).to eql("Post approved successfully")
			end
		end
	end

	describe 'DELETE destroy ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "When admin logged in" do
			it 'Returns success' do
				question = create(:question, accountable: @account)
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				delete :destroy, params: { token: token, id: question.id }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['message']).to eql("Post deleted successfully")
			end
		end
	end

end
