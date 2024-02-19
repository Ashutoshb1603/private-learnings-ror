require 'rails_helper'
RSpec.describe BxBlockContentmanagement::SearchController, type: :controller do

   describe 'GET INDEX' do
      before do
         @account = create(:account, freeze_account: false)
         create(:recent_search , account: @account)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            get :index, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'POST SEARCH' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            post :search, params: { token: @token, search: "ava"}, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'GET AUTO_SUGGEST' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            get :auto_suggest, params: { token: @token, search: "ava"}, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

end
