require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::RadarBoxAircraftDetailsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
    
    @aircraft = FactoryBot.create(:aircraft)
    aircraft_schedule = FactoryBot.create(:aircraft_schedule, aircraft_id: @aircraft.id)
  end

  describe "Get#index" do
    it "show all data" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end