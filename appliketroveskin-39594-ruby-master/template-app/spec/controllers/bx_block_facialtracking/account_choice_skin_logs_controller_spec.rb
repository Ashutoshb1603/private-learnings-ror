require 'rails_helper'
RSpec.describe BxBlockFacialtracking::AccountChoiceSkinLogsController, type: :controller do
   let(:skin_quiz) { create(:skin_quiz, question_type: "consultation") }
   let(:skin_quiz_1) { create(:skin_quiz, question_type: "skin_goal") }
   let(:skin_quiz_2) { create(:skin_quiz, question_type: "skin_log") }
   let(:choice_1) { create(:choice, skin_quiz: skin_quiz) }
   let(:choice_2) { create(:choice, skin_quiz: skin_quiz) }
   let(:account_choice_skin_quiz) { create(:account_choice_skin_quiz, skin_quiz: skin_quiz, account: user, choice: choice_1) }

   describe 'POST create' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass incorrect params" do
         it 'Returns error' do
            skin_quiz = create(:skin_quiz)
            post :create, params: { token: @token, account_choice_skin_log: {skin_quiz_id: skin_quiz.id, other: "sdfg"} }, as: :json
            expect(response).to have_http_status(422)
            expect(JSON.parse(response.body)['errors']['message']).to match_array(["Account must exist"])
         end
      end

      context "when pass incorrect token" do
         it 'Returns Invalid token.' do
            skin_quiz = create(:skin_quiz, question_type: "skin_goal")
            post :create, params: { token: @token, account_choice_skin_log: {skin_quiz_id: skin_quiz.id, other: "sdfg"} }, as: :json
            expect(response).to have_http_status(201)
         end
         it 'Returns Invalid token.' do
            skin_quiz = create(:skin_quiz, question_type: "consultation")
            post :create, params: { token: @token, account_choice_skin_log: {skin_quiz_id: skin_quiz.id, other: "sdfg"} }, as: :json
            expect(response).to have_http_status(201)
         end
         it 'Returns Invalid token.' do
            skin_quiz = create(:skin_quiz, question_type: "skin_log")
            post :create, params: { token: @token, account_choice_skin_log: {skin_quiz_id: skin_quiz.id, other: "sdfg"} }, as: :json
            expect(response).to have_http_status(201)
         end
      end
   end

   describe 'GET SHOW' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         before do
            @account_choice_skin_log = create(:account_choice_skin_quiz, skin_quiz: skin_quiz, account: @account, choice: choice_1)
         end
         it 'Returns success' do
            get :show, params: { token: @token, id: @account_choice_skin_log.id }, as: :json
            expect(response).to have_http_status(200)
            # expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "position", "created_at", "updated_at", "image"])
         end
         it 'Returns success' do
            create(:user_image, account: @account)
            get :show, params: { token: @token, id: @account_choice_skin_log.id, date: Date.today }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'GET consultation_form_show' do
      before do
         skin_quiz
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            get :consultation_form_show, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   describe 'GET skin_goal_answers' do
      before do
         skin_quiz
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            get :skin_goal_answers, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

   
   describe 'GET user_skin_goals' do
      before do
         skin_quiz
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            get :user_skin_goals, params: { token: @token }, as: :json
            expect(response).to have_http_status(200)
         end
      end
   end

end
