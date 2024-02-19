require 'rails_helper'
RSpec.describe BxBlockExplanationText::ExplanationTextsController, type: :controller do

describe 'GET index' do
  before do
    @account = create(:account , freeze_account: false)
    @explanation_text = create(:explanation_text)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass incorrect params" do
    it 'Returns Screen name must be present' do
      get :index, params: { use_route: "/bx_block_explanation_text/" , token: @token }
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["errors"]["message"]).to eql("Screen name must be present")
    end
  end
  context "when pass correct params" do
    it 'Returns success' do
      get :index, params: { use_route: "/bx_block_explanation_text/" , token: @token, screen_name: "Consultation"}
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Screen name must be present")
    end
  end

  context "when pass params screen_name skin_quiz" do
    it 'Returns show list skin_quiz' do
      get :index, params: { use_route: "/bx_block_explanation_text/" , token: @token, screen_name: "skin_quiz"}
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Screen name must be present")
    end
  end
  context "when pass params screen_name skin_quiz" do
    it 'Returns show list landing_page' do
      get :index, params: { use_route: "/bx_block_explanation_text/" , token: @token, screen_name: "landing_page"}
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Screen name must be present")
    end
  end
  context "when pass params screen_name skin_log" do
    it 'Returns show list skin_log' do
      get :index, params: { use_route: "/bx_block_explanation_text/" , token: @token, screen_name: "skin_log"}
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Screen name must be present")
    end
  end
  context "when pass params screen_name profile" do
    it 'Returns show list profile' do
      get :index, params: { use_route: "/bx_block_explanation_text/" , token: @token, screen_name: "profile"}
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Screen name must be present")
    end
  end
  context "when pass params screen_name consultation" do
    it 'Returns show list consultation' do
      get :index, params: { use_route: "/bx_block_explanation_text/" , token: @token, screen_name: "consultation"}
      expect(response).to have_http_status(200)
      # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Screen name must be present")
    end
  end
end
end
