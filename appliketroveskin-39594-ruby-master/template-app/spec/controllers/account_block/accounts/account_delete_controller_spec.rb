require 'rails_helper'
RSpec.describe AccountBlock::Accounts::AccountDeleteController, type: :controller do
  
  let(:role) { FactoryBot.create(:role, name: "User") }
  let(:account) { FactoryBot.create(:email_account, :with_user_role) }
  let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) } 
  let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) } 
  let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) } 
  let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) } 
  let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }

  describe 'GET show' do
    before do
      account && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image && email_cover_image
      @token = BuilderJsonWebToken.encode(account.id, {exp: 15.minutes.from_now.to_i, destroy: true})
    end
    context "when given correct token" do
      it 'Delete the Account successfully' do
        get :show, params: { use_route: "/accounts/account_delete", token: @token, id: account.id }
        expect(response.redirection?).to eql(true)
        expect(response.redirect_url).to eql("https://skindeepapp.page.link/join")
        expect(AccountBlock::Account.first).to eql(nil)
      end
    end

    context "when given expired token" do
      it 'Returns message to request for new link' do
        token = BuilderJsonWebToken.encode(account.id, {exp: (Time.now - 1.hour).to_i, destroy: true})
        get :show, params: { use_route: "/accounts/account_delete", token: token, id: account.id }
        expect(response.redirection?).to eql(false)
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["errors"]).to eql([{"pin"=>"Link expired. Please request a new one."}])
      end
    end

    context "when given incorrect token" do
      it 'Returns error message with invalid link' do
        token = "eybGciOiJIUzUxMiJ9.eyJpZokCI6MywiZXhwIjoxNjk1NTQ2MTA2LCJqd3RfdG9rZW4iOiJhNmJkMjE3ZSIsImFjY291bnRfdHlwZSI6IkVtYWlsQWNjb3VudCJ9.kaa6pHMOTRy7ms5XfnfdiVEOC5XvxFFdzolC5iMOi5C3HYdU_UrFBVZvkVyTUo4fyYh0D0AfugeHDAhMq3R4EA"
        get :show, params: { use_route: "/accounts/account_delete", token: token, id: account.id }
        expect(response).to have_http_status(:bad_request)
        expect(response.redirection?).to eql(false)
        expect(JSON.parse(response.body)["errors"]).to eql([{"token"=>'Invalid link'}])
      end
    end
  end
end