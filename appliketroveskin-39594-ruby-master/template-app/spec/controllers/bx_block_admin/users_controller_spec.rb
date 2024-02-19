require 'rails_helper'
RSpec.describe BxBlockAdmin::UsersController, type: :controller do

	describe 'GET index ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "When admin logged in" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :index, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "name", "full_phone_number", "country_code", "phone_number", "email", "gender", "activated", "device"])
			end
		end
	end

	describe 'PATCH active ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
		end
		context "When admin logged in without passing ids" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				patch :active, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['errors']['message']).to eql('Please pass ids of users to activate users')
			end
		end
		context "When admin logged in with passing ids" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				patch :active, params: { token: token, ids: [@account.id] }, as: :json
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "name", "full_phone_number", "country_code", "phone_number", "email", "gender", "activated", "device"])
			end
		end
	end

	describe 'PUT block_or_unblock ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			create(:dynamic_image, image_type: "email_cover" ) 
  			create(:dynamic_image, image_type: "email_logo" ) 
  			create(:dynamic_image, image_type: "email_tnc_icon" ) 
  			create(:dynamic_image, image_type: "policy_icon" ) 
  			create(:dynamic_image, image_type: "email_profile_icon" )
		end
		context "When user is blocked" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				put :block_or_unblock, params: { token: token, data: { account_id: @account.id} }, as: :json
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['message']).to eql("User unblocked successfully!")
			end
		end
		context "When user is unblocked" do
			it 'Returns success' do
				@account.toggle!(:blocked)
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				put :block_or_unblock, params: { token: token, data: { account_id: @account.id} }, as: :json
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['message']).to eql("User blocked successfully!")
			end
		end
	end

	describe 'PUT upgrade_membership ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			create(:dynamic_image, image_type: "email_cover" ) 
  			create(:dynamic_image, image_type: "email_logo" ) 
  			create(:dynamic_image, image_type: "email_tnc_icon" ) 
  			create(:dynamic_image, image_type: "policy_icon" ) 
  			create(:dynamic_image, image_type: "email_profile_icon" )
		end
		context "When user is blocked" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				put :upgrade_membership, params: { token: token, data: { account_ids: [@account.id]} }, as: :json
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['message']).to eql("Users upgraded successfully!")
			end
		end
	end

	describe 'PUT downgrade_membership ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			create(:dynamic_image, image_type: "email_cover" ) 
  			create(:dynamic_image, image_type: "email_logo" ) 
  			create(:dynamic_image, image_type: "email_tnc_icon" ) 
  			create(:dynamic_image, image_type: "policy_icon" ) 
  			create(:dynamic_image, image_type: "email_profile_icon" )
		end
		context "When user is blocked" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				put :downgrade_membership, params: { token: token, data: { account_ids: [@account.id]} }, as: :json
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['message']).to eql("Users downgraded successfully!")
			end
		end
	end

	describe 'GET elite_eligible_users ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			create(:membership_plan, account: @account, end_date: 1.year.after, start_date: 1.day.before)
			create(:dynamic_image, image_type: "email_cover" ) 
  			create(:dynamic_image, image_type: "email_logo" ) 
  			create(:dynamic_image, image_type: "email_tnc_icon" ) 
  			create(:dynamic_image, image_type: "policy_icon" ) 
  			create(:dynamic_image, image_type: "email_profile_icon" )
		end
		context "When user is blocked" do
			it 'Returns error' do
				user = admin
  				create(:elite_eligibility, interval: "lifetime", eligibility_on: "money_spent")
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :elite_eligible_users, params: { token: token, data: { account_ids: [@account.id]} }, as: :json
				expect(response).to have_http_status(200)
				# expect(JSON.parse(response.body)['message']).to eql("Users upgraded successfully!")
			end
		end
		context "When user is blocked" do
			it 'Returns error' do
				user = admin
  				create(:elite_eligibility, interval: "year", eligibility_on: "product_bought")
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				get :elite_eligible_users, params: { token: token, data: { account_ids: [@account.id]} }, as: :json
				expect(response).to have_http_status(200)
				# expect(JSON.parse(response.body)['message']).to eql("Users upgraded successfully!")
			end
		end
	end

	describe 'PATCH inactive ' do
		let(:admin) { create(:admin_user, freeze_account: false) }
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom", activated: false)
		end
		context "When admin logged in without passing ids" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				patch :inactive, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['errors']['message']).to eql("Please pass ids of users to inactivate users")
			end
		end
		context "When admin logged in with passing ids" do
			it 'Returns success' do
				user = admin
				token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
				patch :inactive, params: { token: token, ids: [@account.id] }, as: :json
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "name", "full_phone_number", "country_code", "phone_number", "email", "gender", "activated", "device"])
			end
		end
	end

end
