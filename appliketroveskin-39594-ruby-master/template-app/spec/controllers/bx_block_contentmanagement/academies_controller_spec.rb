require 'rails_helper'
RSpec.describe BxBlockContentmanagement::AcademiesController, type: :controller do

   describe 'GET INDEX' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            create(:academy)
            get :index, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
         end
         it 'Returns pagination error' do
            create(:academy)
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
            academy = create(:academy)
            get :show, params: { token: @token, id: academy.id }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'POST PURCHASE' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            academy = create(:academy)
            post :purchase, params: { token: @token, id: academy.id }, as: :json
            expect(response).to have_http_status(200)
         end
      end
      context "when admin purchase" do
         it 'Returns error' do
            admin = create(:admin_user)
            token =  BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
            academy = create(:academy)
            post :purchase, params: { token: token, id: academy.id }, as: :json
            expect(response).to have_http_status(422)
         end
      end
   end

   describe 'POST CREATE' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "only admin can create" do
         it 'Returns success' do
            post :create, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['errors']).to eql("Admin access required!")
         end
      end
      context "when admin logged in" do
         it 'Returns Success' do
            admin = create(:admin_user)
            token =  BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
            post :create, params: { token: token, data: {attributes:{  title: "my_title", description: "describe", price: 123.00}}}, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'PUT UPDATE' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "only admin can update" do
         it 'Returns error' do
            academy = create(:academy)
            put :update, params: { token: @token, id: academy.id }, as: :json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['errors']).to eql("Admin access required!")
         end
      end

      context "when pass correct params with admin creds" do
         it 'Returns success' do
            academy = create(:academy)
            admin = create(:admin_user)
            token =  BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
            put :update, params: { token: token, id: academy.id, data: {attributes:{  title: "my_title", description: "describe", price: 123.00}} }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'DELETE DESTROY' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "only admin can update" do
         it 'Returns error' do
            academy = create(:academy)
            delete :destroy, params: { token: @token, id: academy.id }, as: :json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['errors']).to eql("Admin access required!")
         end
      end

      context "when pass correct params with admin creds" do
         it 'Returns success' do
            academy = create(:academy)
            admin = create(:admin_user)
            token =  BuilderJsonWebToken.encode(admin.id, {jwt_token: admin.jwt_token, account_type: admin.type}, 1.year.from_now)
            delete :destroy, params: { token: token, id: academy.id }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

end
