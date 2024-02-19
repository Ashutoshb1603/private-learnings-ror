require 'spec_helper'
require 'rails_helper'
require 'support/devise'

include Warden::Test::Helpers

RSpec.describe Admin::LeonaircraftController, type: :controller do
  before(:each) do
    @admin = AdminUser.find_or_create_by(email: 'admin@example.com')
    @admin.password = "password"
    @admin.save
    sign_in @admin
  end
  render_views

  it 'redirects to login' do
    get :index
    expect(response).to have_http_status(200)
  end

  context 'when logged in as admin' do
    it 'renders page' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end