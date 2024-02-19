require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::FlexAircraftsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
    
    @aircraft = FactoryBot.create(:aircraft)
    aircraft_schedule = FactoryBot.create(:aircraft_schedule, aircraft_id: @aircraft.id)
    aircraft_account_manager = FactoryBot.create(:aircraft_account_manager, aircraft_id: @aircraft.id)
    aircraft_equipment = FactoryBot.create(:aircraft_equipment, aircraft_id: @aircraft.id)
  end

  describe "Get#index" do
    it "show all data" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "Get#show" do
    it "show details" do
      get :show, params: {id: @aircraft&.id}
      expect(response).to have_http_status(200)
    end
  end
end