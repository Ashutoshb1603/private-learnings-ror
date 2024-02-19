require 'rails_helper'
RSpec.describe BxBlockConsultation::ConsultationTypesController, type: :controller do

  describe 'GET index' do
       before do
        @account = create(:account, freeze_account: false)
        @consultation_type = create(:consultation_type)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns show list all consultation' do
         get :index, params: { token: @token }
         expect(response).to have_http_status(200)
         # expect(JSON.parse(response.body)["message"]).to eql("Customer is registered with us.")
      end
       end

      context "when pass incorrect token" do
         it 'Returns Invalid token.' do
         get :index, params: { token: nil }
         expect(response).to have_http_status(400)
         expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
       end
   end
end
