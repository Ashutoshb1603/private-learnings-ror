require 'rails_helper'
RSpec.describe BxBlockSkinClinic::SkinTreatmentLocationsController, type: :controller do

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        create(:skin_treatment_location)
        get :index, params: { use_route: "/payments/" , token: @token }
        expect(response).to have_http_status(200)
      end
    end
  end

end
