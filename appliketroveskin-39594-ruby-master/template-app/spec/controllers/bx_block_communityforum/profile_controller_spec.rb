require 'rails_helper'
RSpec.describe BxBlockCommunityforum::ProfileController, type: :controller do

	describe 'GET INDEX ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				get :index, params: { token: @token }
				expect(response).to have_http_status(200)
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
				get :show, params: { token: @token, id: @account.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'GET SAVED ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				get :saved, params: { token: @token }
				expect(response).to have_http_status(200)
			end
			it "Returns error for pagination" do
				get :saved, params: { token: @token, page: 213456 }
				expect(response).to have_http_status(404)
			end
		end
	end

	describe 'GET my_activity ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				get :my_activity, params: { token: @token }
				expect(response).to have_http_status(200)
			end
			it "Returns error for pagination" do
				get :my_activity, params: { token: @token, page: 213456 }
				expect(response).to have_http_status(404)
			end
		end
	end

	describe 'GET ACTIVITY ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				get :activity, params: { token: @token }
				expect(response).to have_http_status(200)
			end
			it "Returns error for pagination" do
				get :activity, params: { token: @token, page: 213456 }
				expect(response).to have_http_status(404)
			end
		end
	end

end
