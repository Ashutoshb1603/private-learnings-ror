require 'rails_helper'
RSpec.describe BxBlockAdmin::PageClicksController, type: :controller do

  describe 'GET index' do
  	let(:admin) { create(:admin, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
      @advertisement = create(:advertisement)
    end
	context "Only accessible to admin" do
      it 'Returns success' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: token}
        expect(response). to have_http_status(200)
        expect(JSON.parse(response.body).keys).to match_array(["salons", "advertisements", "device_split"])
      end
    end
  end
end
