require 'rails_helper'
RSpec.describe BxBlockFacialtracking::UserImagesController, type: :controller do

   describe 'POST create' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            post :create, params: { token: @token, user_image: {position: "front", image: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.jpeg'), 'image/jpeg')} }, as: :json
            expect(response).to have_http_status(201)
            expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(["id", "position", "account_id", "created_at", "updated_at", "image"])
         end
      end

      context "when pass incorrect token" do
      it 'Returns Invalid token.' do
         post :create, params: { token: nil }
            expect(response).to have_http_status(400)
            expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
         end
      end
      context "when validation fails" do
      it 'Returns Invalid token.' do
         post :create, params: { token: @token, user_image: {position: "front"} }
            expect(response).to have_http_status(422)
            expect(JSON.parse(response.body)["errors"]["message"]).to eql(["Image can't be blank"])
         end
      end
   end

   describe 'GET skin_logs' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         before do
            create(:user_image, account: @account)
         end
         it 'Returns success' do
            get :skin_logs, params: { token: @token, position: "front" }, as: :json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "position", "created_at", "updated_at", "image"])
         end
         it 'Returns success' do
            get :skin_logs, params: { token: @token, position: "front", page: 1 }, as: :json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "position", "created_at", "updated_at", "image"])
         end
         it 'Returns error for pagination' do
            get :skin_logs, params: { token: @token, position: "front", page: 1123456 }, as: :json
            expect(response).to have_http_status(404)
            expect(JSON.parse(response.body)['message']).to eql("Page doesn't exist")
         end
      end
   end

   describe 'GET weekly_skin_diary' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         before do
            create(:user_image, account: @account)
         end
         it 'Returns success' do
            get :weekly_skin_diary, params: { token: @token, start_date: Time.now }, as: :json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['data'].first.keys).to match_array(["date", "image"])
         end
      end
      context "when start_date is not present in params" do
         before do
            create(:user_image, account: @account)
         end
         it 'Returns success' do
            get :weekly_skin_diary, params: { token: @token }, as: :json
            expect(response).to have_http_status(422)
            expect(JSON.parse(response.body)['errors']['message']).to eql('Start date of week is not present.')
         end
      end
   end

   describe 'GET monthly_skin_diary' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         before do
            create(:user_image, account: @account)
         end
         it 'Returns success' do
            get :monthly_skin_diary, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['data'].first['week'].first.keys).to match_array(["month", "week", "start_date", "end_date"])
         end
      end
   end

end
