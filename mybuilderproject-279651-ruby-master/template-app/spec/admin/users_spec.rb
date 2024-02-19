require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::UsersController, :type => :controller do 
	render_views
	before(:each) do
	  @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
	  @admin.password = "password"
	  @admin.save
	  sign_in @admin
    end

    let(:account) { FactoryBot.create(:account) }
    
  	describe "GET active_account" do
    context "when account is found" do
      before { get :active_account, params: { id: account.id } }
      it "redirects to the users index page" do
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context "when account is not found" do
      before { get :active_account, params: { id: "invalid_id" } }

      it "does not set the flash notice message" do
        expect(flash[:notice]).to be_nil
      end

      it "redirects to the users index page" do
        expect(response).to redirect_to(admin_users_path)
      end
    end
  end

    describe "Get#index" do
      it "show all data" do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    describe "Get#show" do
      it "show user details" do
        get :show, params: {id: account.id}
        expect(response).to have_http_status(200)
      end
    end
end