require 'rails_helper'
require 'spec_helper'

RSpec.describe BxBlockShopifyintegration::ShopifyProductsController, type: :controller do
  let(:user) { create(:email_account, :with_user_role) }
  let(:therapist) { create(:email_account, :with_therapist_role) }
  let(:admin) { create(:admin_user) }
  let(:jwt_token) { SecureRandom.hex(4) }

  # describe 'GET clients' do
  #   before(:each) do
  #     user && therapist
  #   end
  #   describe "user logged in" do
  #     it 'when id passed does not exist' do
  #       token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
  #       user.update(jwt_token: jwt_token)
  #       get :clients, params: { id: 67, token: token }
  #       expect(response).to have_http_status(:not_found)
  #       expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
  #     end
  #   end
  # end
end
