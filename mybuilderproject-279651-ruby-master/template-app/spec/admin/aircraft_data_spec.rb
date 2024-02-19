require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::AircraftDataMastersController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
    
    @aircraft = FactoryBot.create(:aircraft, is_file_imported: true)
    aircraft_company = FactoryBot.create(:aircraft_company, aircraft_id: @aircraft.id)
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

  describe "Get#do_import" do
    let(:file) { Rack::Test::UploadedFile.new(Rails.root + "lib/Private_Bombardier.xlsx")}
    it "import details" do
      post :do_import, params: { active_admin_import_model: {file: file} }
      expect(response).to have_http_status(302)
    end

    it "upload file" do
      post :do_import, params: { active_admin_import_model: {} }
      expect(response).to have_http_status(302)
    end
  end
end