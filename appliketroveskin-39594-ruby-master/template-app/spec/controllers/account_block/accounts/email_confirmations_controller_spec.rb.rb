require 'rails_helper'
RSpec.describe AccountBlock::Accounts::EmailConfirmationsController, type: :controller do
  
  let(:role) { FactoryBot.create(:role, name: "User") }
  let(:account) { FactoryBot.create(:email_account, :with_user_role, activated: false) }
  let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) } 
  let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) } 
  let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) } 
  let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) } 
  let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }
  let(:jwt_token) { SecureRandom.hex(4) }

  describe 'GET show' do
    before do
        email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image && email_cover_image
        @user = create(:email_account, :with_user_role, activated: false)
        @account = create(:email_account , role: BxBlockRolesPermissions::Role.find_by(name: "User"))
        @token = BuilderJsonWebToken.encode(@user.id, {jwt_token: jwt_token, account_type: @user.type}, 1.year.from_now)
        @user.update(jwt_token: jwt_token)
    end
    context "when given correct token" do
      it 'Activate the Account successfully' do
        get :show, params: { use_route: "/accounts/email_confirmations", token: @token }
        expect(response.redirection?).to eql(true)
        expect(response.redirect_url).to eql("https://skindeepapp.page.link/join")
        expect(AccountBlock::Account.first.activated).to eql(true)
      end
    end
    context "when given incorrect token" do
      it 'Retuns Account not found' do
        token = BuilderJsonWebToken.encode(50, {jwt_token: jwt_token, account_type: @user.type}, 1.year.from_now)
        get :show, params: { use_route: "/accounts/email_confirmations", token: token }
        expect(response).to have_http_status(401)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Account deleted.")
      end
    end

    context "when given expired token" do
      it 'Returns message to request for new link' do
        token = BuilderJsonWebToken.encode(@account.id, {exp: (Time.now - 1.hour).to_i, destroy: true})
        get :show, params: { use_route: "/accounts/account_delete", token: token, id: @account.id }
        expect(response.redirection?).to eql(false)
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["errors"]).to eql({"message"=>"Token has Expired", "token"=>"Token has Expired"})
      end
    end

    context "when given incorrect token" do
      it 'Returns error message with invalid link' do
        token = "eybGciOiJIUzUxMiJ9.eyJpZokCI6MywiZXhwIjoxNjk1NTQ2MTA2LCJqd3RfdG9rZW4iOiJhNmJkMjE3ZSIsImFjY291bnRfdHlwZSI6IkVtYWlsQWNjb3VudCJ9.kaa6pHMOTRy7ms5XfnfdiVEOC5XvxFFdzolC5iMOi5C3HYdU_UrFBVZvkVyTUo4fyYh0D0AfugeHDAhMq3R4EA"
        get :show, params: { use_route: "/accounts/account_delete", token: token, id: @account.id }
        expect(response).to have_http_status(:bad_request)
        expect(response.redirection?).to eql(false)
        expect(JSON.parse(response.body)["errors"]).to eql({"message"=>"Invalid token", "token"=>"Invalid token"})
      end
    end
  end
end