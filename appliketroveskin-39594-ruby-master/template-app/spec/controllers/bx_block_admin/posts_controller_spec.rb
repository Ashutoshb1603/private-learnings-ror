require 'rails_helper'
RSpec.describe BxBlockAdmin::PostsController, type: :controller do

  describe 'POST add_or_remove_recommendation ' do
  	let(:admin) { create(:admin_user, :with_admin_role, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
	context "Only accessible to admin" do
      it 'Returns error' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :add_or_remove_recommendation, params: {token: token}
        expect(response). to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
      end
    end
    context "When admin logged in" do
      it 'Returns success' do
      	user = admin
      	question_id = create(:question, accountable: admin, recommended: false).id
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        post :add_or_remove_recommendation, params: {token: token, post_id: question_id}
        expect(BxBlockCommunityforum::Question.find(question_id).recommended).to eql(true)
        expect(response). to have_http_status(200)
        expect(JSON.parse(response.body)['message']).to eql("Post recommendation updated")
      end
    end
  end
end
