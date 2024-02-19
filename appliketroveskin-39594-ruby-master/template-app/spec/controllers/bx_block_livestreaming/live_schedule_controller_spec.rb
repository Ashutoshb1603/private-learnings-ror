require 'rails_helper'
RSpec.describe BxBlockLivestreaming::LiveScheduleController, type: :controller do
	let(:user) { create(:email_account, :with_user_role) }
	let(:jwt_token) { SecureRandom.hex(4) }

	describe 'GET index' do
		before(:each) do
			@user = user
			create(:live_schedule)
		end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
				@user.update(jwt_token:@user.jwt_token)
				get :index, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['errors']).to eql(["Account is not associated to an admin"])
			end
		end
		context "when admin logged in" do
			it 'Returns success' do
				admin = create(:admin_user)
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:@user.jwt_token)
				get :index, params: { token: token }
				expect(response).to have_http_status(200)
				# expect(JSON.parse(response.body)['errors']).to eql(["Account is not associated to an admin"])
			end
		end
	end

	describe 'POST CREATE' do
		before(:each) do
			@user = user
		end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
				@user.update(jwt_token:@user.jwt_token)
				post :create, params: { token: token }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['errors']).to eql(["Account is not associated to an admin"])
			end
		end
		context "when admin logged in" do
			it 'Returns success' do
				admin = create(:admin_user)
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:@user.jwt_token)
				post :create, params: { token: token, data: { attributes: { at: Time.now, user_type: "all", event_creation_notification: true, guest_email: "test@opamil.com" } } }
				expect(response).to have_http_status(201)
			end
			it 'Returns success' do
				admin = create(:admin_user)
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:@user.jwt_token)
				post :create, params: { token: token, data: { attributes: { at: Time.now, user_type: "elite_and_glow_getters", event_creation_notification: true, guest_email: "test@opamil.com" } } }
				expect(response).to have_http_status(201)
			end
			it 'Returns success' do
				admin = create(:admin_user)
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:@user.jwt_token)
				post :create, params: { token: token, data: { attributes: { at: Time.now, user_type: "free", event_creation_notification: true, guest_email: "test@opamil.com" } } }
				expect(response).to have_http_status(201)
			end
			it 'Returns success' do
				admin = create(:admin_user)
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:@user.jwt_token)
				post :create, params: { token: token, data: { attributes: { at: Time.now, user_type: "asdfg", event_creation_notification: true, guest_email: "test@opamil.com" } } }
				expect(response).to have_http_status(201)
			end
		end
	end


	describe 'DELETE DESTROY' do
		before(:each) do
			@user = user
		end
		context "Only accessible to admin" do
			it 'Returns error' do
				live_schedule = create(:live_schedule, user_type: "all")
				token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
				@user.update(jwt_token:@user.jwt_token)
				delete :destroy, params: { token: token, id: live_schedule.id }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['errors']).to eql(["Account is not associated to an admin"])
			end
		end
		context "when admin logged in" do
			it 'Returns success' do
				admin = create(:admin_user)
				live_schedule = create(:live_schedule, user_type: "all")
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:user.jwt_token)
				delete :destroy, params: { token: token, id: live_schedule.id }
				expect(response).to have_http_status(200)
			end
		end
		context "when admin logged in" do
			it 'Returns success' do
				admin = create(:admin_user)
				live_schedule = create(:live_schedule, user_type: "free")
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:user.jwt_token)
				delete :destroy, params: { token: token, id: live_schedule.id }
				expect(response).to have_http_status(200)
			end
		end
		context "when admin logged in" do
			it 'Returns success' do
				admin = create(:admin_user)
				live_schedule = create(:live_schedule, user_type: "elite_and_glow_getters")
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:user.jwt_token)
				delete :destroy, params: { token: token, id: live_schedule.id }
				expect(response).to have_http_status(200)
			end
		end
		context "when admin logged in" do
			it 'Returns success' do
				admin = create(:admin_user)
				live_schedule = create(:live_schedule, user_type: "asdfg")
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:user.jwt_token)
				delete :destroy, params: { token: token, id: live_schedule.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'PUT UPDATE' do
		before(:each) do
			@user = user
		end
		context "Only accessible to admin" do
			it 'Returns error' do
				live_schedule = create(:live_schedule, user_type: "all")
				token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
				@user.update(jwt_token:@user.jwt_token)
				put :update, params: { token: token, id: live_schedule.id }
				expect(response).to have_http_status(200)
				expect(JSON.parse(response.body)['errors']).to eql(["Account is not associated to an admin"])
			end
		end
		context "when admin logged in" do
			it 'Returns success' do
				admin = create(:admin_user)
				live_schedule = create(:live_schedule, user_type: "all")
				token = BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
				admin.update(jwt_token:user.jwt_token)
				put :update, params: { token: token, id: live_schedule.id, data: { attributes: { at: Time.now, user_type: "all", event_creation_notification: true, guest_email: "test@opamil.com" } } }
				expect(response).to have_http_status(200)
			end
		end
	end

end


