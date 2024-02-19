require 'rails_helper'
RSpec.describe BxBlockFaqs::FaqsController, type: :controller do

  describe 'GET index' do
    before do
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      create(:faq)
    end

    context "when pass incorrect params" do
      it 'Returns Screen name must be present' do
        get :index, params: { token: @token }
        expect(response).to have_http_status(200)
      end
    end
  end
end
