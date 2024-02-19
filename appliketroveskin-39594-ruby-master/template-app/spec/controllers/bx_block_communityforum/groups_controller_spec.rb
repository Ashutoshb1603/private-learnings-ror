require 'rails_helper'
RSpec.describe BxBlockCommunityforum::GroupsController, type: :controller do

	describe 'GET INDEX ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				create(:group, status: 'active')
				get :index, params: { token: @token }
				expect(response).to have_http_status(200)
			end
			it "Returns error for pagination" do
				create(:group, status: 'active')
				get :index, params: { token: @token, page: 213456 }
				expect(response).to have_http_status(404)
			end
		end
	end

	describe 'GET SHOW ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				group = create(:group, status: 'active')
				get :show, params: { token: @token, id: group.id }
				expect(response).to have_http_status(200)
			end
			it "Returns error for pagination" do
				group = create(:group, status: 'active')
				get :show, params: { token: @token, id: group.id, page: 213456 }
				expect(response).to have_http_status(404)
			end
		end
	end

	describe 'POST CREATE ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns only admin can access' do
				post :create, params: { token: @token, data: {attributes: { title: "My title"}} }
				expect(response).to have_http_status(200)
			end
		end
		context "When user logged in with no params" do
			it 'Returns only admin can access' do
				admin = create(:admin_user)
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				post :create, params: { token: token, data: {attributes: { title: "My title"}} }
				expect(response).to have_http_status(200)
			end
		end
	end

end
