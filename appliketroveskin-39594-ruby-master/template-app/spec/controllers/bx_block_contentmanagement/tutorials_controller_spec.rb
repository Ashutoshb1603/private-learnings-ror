require 'rails_helper'
RSpec.describe BxBlockContentmanagement::TutorialsController, type: :controller do

   describe 'GET INDEX' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            create(:tutorial)
            get :index, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
         end
         it 'Returns pagination error' do
            create(:tutorial)
            get :index, params: { token: @token, page: 8765432 }, as: :json
            expect(response).to have_http_status(404)
         end
      end
   end

   describe 'GET SHOW' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            tutorial = create(:tutorial)
            get :show, params: { token: @token, id: tutorial.id }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'POST LIKE' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            tutorial = create(:tutorial)
            post :like, params: { token: @token, id: tutorial.id }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

end
