require 'rails_helper'
RSpec.describe BxBlockLandingpage::LandingpagesController, :type=>:controller do 
  before(:all) do
    if BxBlockLandingpage::Landingpage.count<1
      @landing_page=FactoryBot.create(:landingpage)
    end
  end
  describe 'bx_block_landingpage/landingpages/:id' do
    it 'should return landing page' do
      get :show, format: :json, params: {id: 2}
      expect(response).to have_http_status(:ok)
    end
    it 'should return error' do
      BxBlockLandingpage::Landingpage.destroy_all
      get :show, format: :json, params: {id: 1}
      expect(response).to have_http_status(:not_found)
    end
  end
end