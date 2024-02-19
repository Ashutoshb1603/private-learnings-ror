require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::FlexCrewDetailsController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
    
    # @role = BxBlockRolesPermissions::Role.find_or_create_by(name: 'stylist')
    @crew = FactoryBot.create(:crew)
    crew_role = FactoryBot.create(:crew_role, crew_id: @crew.id)
    crew_preference = FactoryBot.create(:crew_preference, crew_id: @crew.id)
    crew_account = FactoryBot.create(:crew_account, crew_id: @crew.id)
  end

  describe "Get#index" do
      it "show all data" do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    describe "Get#show" do
      it "show user details" do
        get :show, params: {id: @crew&.id}
        expect(response).to have_http_status(200)
      end
    end
end