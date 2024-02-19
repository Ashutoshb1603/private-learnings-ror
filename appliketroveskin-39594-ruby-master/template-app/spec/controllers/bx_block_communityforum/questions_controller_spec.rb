require 'rails_helper'
RSpec.describe BxBlockCommunityforum::QuestionsController, type: :controller do
	let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) } 
	let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) } 
	let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) } 
	let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) } 
	let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }
	describe 'GET index ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				get :index, params: { token: @token }
				expect(response).to have_http_status(200)
			end
		end
		context "When user logged in with sort params" do
			it 'Returns pagination error' do
				get :index, params: { token: @token, sort: "recommended" }
				expect(response).to have_http_status(200)
			end
		end
		context "When user logged in with sort params" do
			it 'Returns pagination error' do
				get :index, params: { token: @token, sort: "popular" }
				expect(response).to have_http_status(200)
			end
		end
		context "When user logged in with page params" do
			it 'Returns pagination error' do
				get :index, params: { token: @token, page: 1234567 }
				expect(response).to have_http_status(404)
			end
		end
	end

	describe 'PSOT create ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				post :create, params: { token: @token, data: { attributes: { title: "titile", description: "describe", status: "active", anonymous: "true", images: [], group_ids: [] }} }
				expect(response).to have_http_status(200)
			end
		end
		context "When user logged in with no params" do
			before do
				create(:bad_wordset)
				email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
			end
			it 'Returns success' do
				post :create, params: { token: @token, data: { attributes: { title: "anal", description: "anal", status: "active", anonymous: "true", images: [], group_ids: [] }} }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'PUT update ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				question = create(:question, accountable: @account, offensive: true)
				put :update, params: { token: @token, id: question.id, data: { attributes: { title: "titile", description: "describe", status: "active", anonymous: "true", images: [], group_ids: [] }} }
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
				question = create(:question, accountable: @account, offensive: true)
				get :show, params: { token: @token, id: question.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST LIKE' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				question = create(:question, accountable: @account, offensive: true)
				post :like, params: { token: @token, id: question.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST saved' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				question = create(:question, accountable: @account, offensive: true)
				post :saved, params: { token: @token, id: question.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST COMMENT' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				question = create(:question, accountable: @account, offensive: true)
				post :comment, params: { token: @token, id: question.id, data: {description: "my description", image: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.jpeg'), 'image/jpeg') }}, as: :json
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST REPORT' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				question = create(:question, accountable: @account, offensive: true)
				post :report, params: { token: @token, id: question.id}
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'DELETE DESTROY' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				question = create(:question, accountable: @account, offensive: true)
				delete :destroy, params: { token: @token, id: question.id}
				expect(response).to have_http_status(200)
			end
		end
	end

end
