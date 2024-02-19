require 'rails_helper'
RSpec.describe BxBlockFacialtracking::AccountChoiceSkinQuizzesController, type: :controller do
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

      context "when pass correct params" do
         it 'Returns success' do
            skin_quiz = create(:skin_quiz)
            post :create, params: { token: @token, account_choice_skin_quiz: {skin_quiz_id: skin_quiz.id, choice_id: choice_1.id, account_id: @account.id} }, as: :json
            expect(response).to have_http_status(201)
         end
      end
      context "when pass incorrect params" do
         it 'Returns error' do
            post :create, params: { token: @token, account_choice_skin_quiz: { choice_id: choice_1.id, account_id: @account.id} }, as: :json
            expect(response).to have_http_status(422)
            expect(JSON.parse(response.body)['errors']['message']).to match_array(["Skin quiz must exist"])
         end
      end
   end

   describe 'GET quiz_answer' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         before do
            @account_choice_skin_log = create(:account_choice_skin_quiz, skin_quiz: skin_quiz, account: @account, choice: choice_1)
         end
         it 'Returns success' do
            get :quiz_answer, params: { token: @token, skin_quiz_id: skin_quiz.id }, as: :json
            expect(response).to have_http_status(201)
         end
         it 'Returns error' do
            get :quiz_answer, params: { token: @token }, as: :json
            expect(response).to have_http_status(422)
         end
      end
   end

end
