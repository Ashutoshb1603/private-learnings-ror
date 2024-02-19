require 'rails_helper'
RSpec.describe BxBlockAdmin::TopController, type: :controller do

  describe 'GET index ' do
  	let(:admin) { create(:admin_user, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
	context "Only accessible to admin" do
      it 'Returns error' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: token}
        expect(response). to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
      end
    end
    context "When admin logged in" do
    	it 'Returns success' do
	      	user = admin
	      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
	        get :index, params: { token: token }
	        expect(response).to have_http_status(200)
	        expect(JSON.parse(response.body).keys).to match_array(["page_views", "blogs", "tutorials", "forums", "top_users"])
      	end
    end
  end

end
