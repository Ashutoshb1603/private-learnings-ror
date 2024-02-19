require 'rails_helper'
RSpec.describe BxBlockFacialtracking::SkinQuizzesController, type: :controller do

   describe 'GET index' do
      before do
         @account = create(:account, freeze_account: false)
         @skin_quiz = create(:skin_quiz)
         @choice = create(:choice, skin_quiz: @skin_quiz)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns success' do
            get :index, params: { token: @token, question_type: @skin_quiz.question_type }, as: :json
            expect(response).to have_http_status(200)
            # expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(["id", "position", "account_id", "created_at", "updated_at", "image"])
         end
      end
   end

end
