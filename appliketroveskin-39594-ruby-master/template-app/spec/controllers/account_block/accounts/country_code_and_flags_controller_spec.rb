require 'rails_helper'
RSpec.describe AccountBlock::Accounts::CountryCodeAndFlagsController, type: :controller do

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
        get :show, params: { use_route: "/accounts/", token: @token, id: account.id }
        expect(response).to have_http_status(200)
      end
    end
  end
end
