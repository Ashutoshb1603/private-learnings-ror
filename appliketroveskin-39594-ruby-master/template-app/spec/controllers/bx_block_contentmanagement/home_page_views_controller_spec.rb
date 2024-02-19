require 'rails_helper'
RSpec.describe BxBlockContentmanagement::HomePageViewsController, type: :controller do

   describe 'POST CREATE' do
      before do
         @account = create(:account, freeze_account: false)
         @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when admin logged in" do
         it 'Returns Success' do
            post :create, params: { token: @token }
            expect(response).to have_http_status(200)
         end
      end
   end

end
