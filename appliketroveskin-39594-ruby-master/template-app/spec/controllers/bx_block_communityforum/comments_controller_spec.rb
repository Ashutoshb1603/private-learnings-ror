require 'rails_helper'
RSpec.describe BxBlockCommunityforum::CommentsController, type: :controller do
	
	describe 'PUT update ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			@question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				comment = create(:comment, accountable: @account, objectable: @question)
				put :update, params: { token: @token, id: comment.id, data: { description: "describe", image: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.jpeg'), 'image/jpeg')} }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'GET SHOW ' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			@question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				comment = create(:comment, accountable: @account, objectable: @question)
				get :show, params: { token: @token, id: comment.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST LIKE' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			@question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				comment = create(:comment, accountable: @account, objectable: @question)
				post :like, params: { token: @token, id: comment.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST REPLY' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			@question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				comment = create(:comment, accountable: @account, objectable: @question)
				post :reply, params: { token: @token, id: comment.id, data: {description: "my description", image: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.jpeg'), 'image/jpeg') }}, as: :json
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST REPORT' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			@question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				comment = create(:comment, accountable: @account, objectable: @question)
				post :report, params: { token: @token, id: comment.id}
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'DELETE DESTROY' do
		before do
			@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
			@question = create(:question, accountable: @account, offensive: true)
		end
		context "When user logged in with no params" do
			it 'Returns success' do
				comment = create(:comment, accountable: @account, objectable: @question)
				delete :destroy, params: { token: @token, id: comment.id}
				expect(response).to have_http_status(200)
			end
		end
	end

end
