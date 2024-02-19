require 'rails_helper'
RSpec.describe BxBlockAdmin::DashboardsController, type: :controller do

	describe 'GET user_counts ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
				get :user_counts, params: {token: token}
				expect(response). to have_http_status(422)
				expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
			end
		end
		context "When admin logged in" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :user_counts, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['data']['android_user_counts']).to eql(1)
			end
		end
	end

	describe 'GET advertisement_counts ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
				get :advertisement_counts, params: {token: token}
				expect(response). to have_http_status(422)
				expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
			end
		end
		context "When admin logged in" do
			it 'Returns success' do
				user = admin
				ad = create(:advertisement)
				create(:page_click, objectable: ad, accountable: @account)
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :advertisement_counts, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['data'].first).to eql({"url"=>"https://google.com", "count"=>1})
			end
		end
	end

	describe 'GET login_time ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
				get :login_time, params: {token: token}
				expect(response). to have_http_status(422)
				expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
			end
		end
		context "When admin logged in with start_date and end_date params" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :login_time, params: { token: token, start_date: 1.year.before, end_date: Time.now }
				expect(response).to have_http_status(200)
				# expect(JSON.parse(response.body)['data'].first).to eql({"url"=>"https://google.com", "count"=>1})
			end
		end
		context "When admin logged in" do
			before do
				create(:active_hour, account: @account)
				glow = create(:account)
				elite = create(:account)
				create(:membership_plan, account: elite, plan_type: "elite", end_date: 1.year.after)
				create(:membership_plan, account: glow, plan_type: "glow_getter", end_date: 1.year.after)
				create(:active_hour, account: glow)
				create(:active_hour, account: elite)
			end
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :login_time, params: { token: token }
				expect(response).to have_http_status(200)
				# expect(JSON.parse(response.body)['data'].first).to eql({"url"=>"https://google.com", "count"=>1})
			end
		end

	end

end
